import 'package:taxito/core/enum/choose_enum.dart';
import 'package:taxito/core/enum/order_type.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import '../../../../../core/services/socket/socket.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../data/models/request/delivery_order_params.dart';
import 'package:taxito/core/data/models/orders.dart';
import '../../domain/usecases/get_all_delivery_orders_use_case.dart';

part 'delivery_order_state.dart';

@Injectable()
class DeliveryOrderCubit extends Cubit<DeliveryOrderState> {
  final GetAllDeliveryOrdersUseCase _getAllDeliveryOrdersUseCase;
  final SocketService socketService;

  DeliveryOrderCubit(this._getAllDeliveryOrdersUseCase, this.socketService)
    : super(DeliveryOrderInitial());

  bool _isHandlingTrip = false;
  final Set<num> _recentTripIds = {};

  void Function(Orders)? onOrderAddedToPending;

  Future<void> listenToTripsRequests() async {
    socketService.onEvent("notify-supplier", (data) async {
      if (_isHandlingTrip) return;
      _isHandlingTrip = true;
      try {
        final orderModel = Orders.fromJson(data['order'], withTime: true);
        final orderId = orderModel.id;
        if (_recentTripIds.contains(orderId)) {
          return;
        }
        _recentTripIds.add(orderId!);
        Future.delayed(
          const Duration(seconds: 3),
          () => _recentTripIds.remove(orderId),
        );
        if (!isClosed) {
          _addOrderToPending(orderModel);
          emit(ReceiveOrderRequestState(order: orderModel));
        }
      } catch (e, s) {
        print("❌ Error handling trip socket: $e\n$s");
      } finally {
        _isHandlingTrip = false;
      }
    });
  }

  final PagingController<int, Orders> pagingControllerNew = PagingController(
    firstPageKey: 1,
  );
  final PagingController<int, Orders> pagingControllerInPrepareSupplier =
      PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerDonePrepare =
      PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerWithDelegate =
      PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerDelivered =
      PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerCanceled =
      PagingController(firstPageKey: 1);

  Future<List<Orders>> fetchDeliveryOrders({
    required int pageKey,
    required DeliveryParams delivery,
  }) async {
    List<Orders> list = [];
    final response = await _getAllDeliveryOrdersUseCase(params: delivery);
    response.fold(
      (l) {
        list = [];
      },
      (r) {
        list = r.data;
      },
    );
    return list;
  }

  Future<void> fetchPage(
    DeliveryParams params,
    PagingController<int, Orders> pagingController,
  ) async {
    try {
      final newItems = await fetchDeliveryOrders(
        pageKey: params.pageKey ?? 1,
        delivery: params,
      );
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = (params.pageKey ?? 1) + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
      try {
        if (params.status == OrderType.pending && (newItems.isNotEmpty)) {
          for (final order in newItems) {
            onOrderAddedToPending?.call(order);
          }
        }
      } catch (_) {}
    } catch (error) {
      pagingController.error = error;
    }
  }

  void _addOrderToPending(Orders order) {
    try {
      final currentItems = pagingControllerNew.itemList ?? [];
      if (!currentItems.any((item) => item.id == order.id)) {
        final updatedList = [order, ...currentItems];
        final currentState = pagingControllerNew.value;
        pagingControllerNew.value = PagingState(
          nextPageKey: currentState.nextPageKey,
          itemList: updatedList,
          error: currentState.error,
        );

        print("✅ Order ${order.id} added to pending list");
        onOrderAddedToPending?.call(order);
      }
    } catch (e) {
      print("❌ Error adding order to pending: $e");
    }
  }

  // Helper method: Remove order from pending list
  void removeOrderFromPending(num orderId) {
    try {
      final currentPending = pagingControllerNew.itemList ?? [];
      final updatedPending = currentPending
          .where((item) => item.id != orderId)
          .toList();

      // Get current pagination state
      final currentState = pagingControllerNew.value;

      // Update the list and refresh the controller by creating a new state
      pagingControllerNew.value = PagingState(
        nextPageKey: currentState.nextPageKey,
        itemList: updatedPending,
        error: currentState.error,
      );

      print("✅ Order $orderId removed from pending list");
    } catch (e) {
      print("❌ Error removing order from pending: $e");
    }
  }

  // General method: Remove order from any paging controller
  void removeOrderFromController(
    PagingController<int, Orders> controller,
    num orderId,
  ) {
    try {
      final currentItems = controller.itemList ?? [];
      final updatedItems = currentItems
          .where((item) => item.id != orderId)
          .toList();

      final currentState = controller.value;

      controller.value = PagingState(
        nextPageKey: currentState.nextPageKey,
        itemList: updatedItems,
        error: currentState.error,
      );

      print("✅ Order $orderId removed from controller");
    } catch (e) {
      print("❌ Error removing order from controller: $e");
    }
  }

  // General method: Add order to any paging controller
  void addOrderToController(
    PagingController<int, Orders> controller,
    Orders order,
  ) {
    try {
      final currentItems = controller.itemList ?? [];
      if (!currentItems.any((item) => item.id == order.id)) {
        final updatedList = [order, ...currentItems];
        final currentState = controller.value;

        controller.value = PagingState(
          nextPageKey: currentState.nextPageKey,
          itemList: updatedList,
          error: currentState.error,
        );

        print("✅ Order ${order.id} added to controller");
      }
    } catch (e) {
      print("❌ Error adding order to controller: $e");
    }
  }
}
