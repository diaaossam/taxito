import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/data/models/orders.dart';
import 'package:bloc/bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../domain/usecases/get_order_list_use_case.dart';

part 'orders_state.dart';

@Injectable()
class OrdersCubit extends Cubit<OrdersState> {
  final GetOrderListUseCase _getOrderListUseCase;

  final PagingController<int, Orders> pagingControllerPending = PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerConfirmed = PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerInPrepareSupplier = PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerDonePrepare = PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerOutForDeleivery = PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerDelivered= PagingController(firstPageKey: 1);
  final PagingController<int, Orders> pagingControllerCanceled = PagingController(firstPageKey: 1);

  OrdersCubit(this._getOrderListUseCase) : super(OrdersInitial());

  Future<List<Orders>> fetchOrders(
      {required int pageKey, required OrderType orderType}) async {
    List<Orders> list = [];
    final response = await _getOrderListUseCase(orderType: orderType, pageKey: pageKey);
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

  Future<void> fetchPage(int pageKey, OrderType orderType,
      PagingController<int, Orders> pagingController) async {
    try {
      final newItems =
          await fetchOrders(pageKey: pageKey, orderType: orderType);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }
}
