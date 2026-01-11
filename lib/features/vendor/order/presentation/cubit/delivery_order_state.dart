part of 'delivery_order_cubit.dart';

abstract class DeliveryOrderState {
  const DeliveryOrderState();
}

class DeliveryOrderInitial extends DeliveryOrderState {}

class ReceiveOrderRequestState extends DeliveryOrderState {
  final Orders order;

  ReceiveOrderRequestState({required this.order});
}
