part of 'delivery_actions_cubit.dart';

@immutable
sealed class DeliveryActionsState {}

final class DeliveryActionsInitial extends DeliveryActionsState {}

class UpdateOrderLoading extends DeliveryActionsState {}

class UpdateOrderSuccess extends DeliveryActionsState {
  final int id;
  final String ? status;
  UpdateOrderSuccess({required this.id ,this.status});
}

class UpdateOrderFailure extends DeliveryActionsState {
  final String msg;

  UpdateOrderFailure({required this.msg});
}

class RejectOrderState extends DeliveryActionsState {}

class RejectTripRequestLoadingState extends DeliveryActionsState {}

class RejectTripRequestSuccessState extends DeliveryActionsState {
  final Orders orders;

  RejectTripRequestSuccessState({required this.orders});
}

// Timer update state
class OrderTimerUpdateState extends DeliveryActionsState {
  final num orderId;
  final int remainingSeconds;

  OrderTimerUpdateState({required this.orderId, required this.remainingSeconds});
}

// Order auto-rejected state
class OrderAutoRejectedState extends DeliveryActionsState {
  final Orders order;

  OrderAutoRejectedState({required this.order});
}

class GetOrderInfoLoading extends DeliveryActionsState {}

class GetOrderInfoSuccess extends DeliveryActionsState {
  final Orders orders;

  GetOrderInfoSuccess({required this.orders});
}

class GetOrderInfoFailure extends DeliveryActionsState {
  final String msg;

  GetOrderInfoFailure({required this.msg});
}
