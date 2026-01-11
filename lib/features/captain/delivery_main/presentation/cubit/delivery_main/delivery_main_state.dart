part of 'delivery_main_cubit.dart';

abstract class DeliveryMainState {
  const DeliveryMainState();
}

class HomeInitial extends DeliveryMainState {}

class ChangeCurrentIndex extends DeliveryMainState {}

class GetTripByUUidLoading extends DeliveryMainState {}

class GetTripByUUidFailure extends DeliveryMainState {}

class GetTripByUUidSuccess extends DeliveryMainState {
  final TripModel tripModel;

  GetTripByUUidSuccess({required this.tripModel});
}
