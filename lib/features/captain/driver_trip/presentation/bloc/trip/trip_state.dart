part of 'trip_cubit.dart';

@immutable
sealed class TripState {}

final class TripInitial extends TripState {}
final class UpdateTripModelState extends TripState {
  final TripModel? tripModel;

  UpdateTripModelState({
    this.tripModel,
  });
}

final class GetTripByIdLoading extends TripState {}

final class GetTripByIdSuccess extends TripState {
  final TripModel tripModel;

  GetTripByIdSuccess({required this.tripModel});
}

final class GetTripByIdFailure extends TripState {
  final String errorMsg;

  GetTripByIdFailure({required this.errorMsg});
}
