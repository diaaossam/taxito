import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import '../../../../../../core/services/network/error/failures.dart';
import '../../../../../../core/services/network/success_response.dart';
import '../../../../../../core/services/socket/socket.dart';
import '../../../data/models/response/orders.dart';
import '../../../domain/usecases/get_order_details_use_case.dart';
import '../../../domain/usecases/update_delivery_order_use_case.dart';

part 'delivery_actions_state.dart';

@Injectable()
class DeliveryActionsCubit extends Cubit<DeliveryActionsState> {
  final UpdateDeliveryOrderUseCase updateDeliveryOrderUseCase;
  final GetOrderDetailsUseCase getOrderDetailsUseCase;
  final SocketService socketService;

  DeliveryActionsCubit(
    this.updateDeliveryOrderUseCase,
    this.socketService,
    this.getOrderDetailsUseCase,
  ) : super(DeliveryActionsInitial());

  final Map<num, Timer> _pendingOrderTimers = {};
  final Map<num, int> _orderRemainingSeconds = {};
  final int _orderTimeoutSeconds = 45; // 45 seconds countdown

  // Start timer for order auto-rejection
  void startOrderTimer(Orders order) {
    final orderId = order.id;
    if (orderId == null) return;

    // Cancel existing timer if any
    _pendingOrderTimers[orderId]?.cancel();

    // Initialize remaining seconds
    _orderRemainingSeconds[orderId] = _orderTimeoutSeconds;

    // Start periodic timer that updates every second
    _pendingOrderTimers[orderId] = Timer.periodic(const Duration(seconds: 1), (
      timer,
    ) {
      final remaining = _orderRemainingSeconds[orderId];
      if (remaining == null || remaining <= 0) {
        timer.cancel();
        print("⏱️ Timer expired for order $orderId - Moving to rejected");
        _moveToRejected(order);
      } else {
        _orderRemainingSeconds[orderId] = remaining - 1;
        // Emit state update to notify UI
        if (!isClosed) {
          emit(
            OrderTimerUpdateState(
              orderId: orderId,
              remainingSeconds: remaining - 1,
            ),
          );
        }
      }
    });
    print("⏱️ Started ${_orderTimeoutSeconds}s timer for order $orderId");
  }

  // Move order from pending to rejected when timer expires
  void _moveToRejected(Orders order) {
    try {
      final orderId = order.id;
      if (orderId == null) return;
      _pendingOrderTimers.remove(orderId);
      _orderRemainingSeconds.remove(orderId);
      if (!isClosed) {
        emit(OrderAutoRejectedState(order: order));
      }

      print("✅ Order $orderId moved to rejected due to timeout");
    } catch (e) {
      print("❌ Error moving order to rejected: $e");
    }
  }

  // Reject order manually
  Future<void> rejectOrder({required Orders order}) async {
    final orderId = order.id;
    if (orderId == null) return;
    cancelOrderTimer(orderId);
    await updateOrder(status: "canceled", id: orderId);
    socketService.emitEvent("reject-order", {"tripId": order.id});
    if (!isClosed) {
      emit(RejectTripRequestSuccessState(orders: order));
    }
    print("✅ Order $orderId rejected manually");
  }

  Future<void> updateOrder({
    required String status,
    required num id,
    bool cancelTimer = false,
  }) async {
    emit(UpdateOrderLoading());
    Either<Failure, ApiSuccessResponse> response;
    if (cancelTimer) {
      cancelOrderTimer(id);
    }
    response = await updateDeliveryOrderUseCase(id: id, status: status);
    response.fold(
      (l) {
        emit(UpdateOrderFailure(msg: l.msg));
      },
      (r) {
        emit(UpdateOrderSuccess(id: id.toInt(), status: status));
      },
    );
  }

  void cancelOrderTimer(num orderId) {
    final timer = _pendingOrderTimers[orderId];
    if (timer != null) {
      timer.cancel();
      _pendingOrderTimers.remove(orderId);
      _orderRemainingSeconds.remove(orderId);
      print("✅ Timer canceled for order $orderId");
    }
  }

  int? getRemainingSeconds(num orderId) {
    return _orderRemainingSeconds[orderId];
  }

  Future<void> getOrderDetails({required int id}) async {
    emit(GetOrderInfoLoading());
    final response = await getOrderDetailsUseCase(id: id);
    emit(
      response.fold(
        (l) {
          return GetOrderInfoFailure(msg: l.msg);
        },
        (r) {
          return GetOrderInfoSuccess(orders: r.data);
        },
      ),
    );
  }

  @override
  Future<void> close() {
    // Cancel all active timers
    for (var timer in _pendingOrderTimers.values) {
      timer.cancel();
    }
    _pendingOrderTimers.clear();
    _orderRemainingSeconds.clear();
    print("✅ All order timers canceled in DeliveryActionsCubit");
    return super.close();
  }
}
