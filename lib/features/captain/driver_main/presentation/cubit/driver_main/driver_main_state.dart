part of 'driver_main_cubit.dart';

abstract class DriverMainState {
  const DriverMainState();
}

class HomeInitial extends DriverMainState {}

class ChangeCurrentIndex extends DriverMainState {}

class GetTripByUUidLoading extends DriverMainState {}

class GetTripByUUidFailure extends DriverMainState {}

class GetTripByUUidSuccess extends DriverMainState {
  final TripModel tripModel;

  GetTripByUUidSuccess({required this.tripModel});
}
