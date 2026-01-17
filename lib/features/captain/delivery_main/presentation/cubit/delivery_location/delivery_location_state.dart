part of 'delivery_location_cubit.dart';

@immutable
sealed class DeliveryLocationState {}

final class DeliveryLocationInitial extends DeliveryLocationState {}
final class GetCurrentLocationFailureState extends DeliveryLocationState {
  final String errorMsg;

  GetCurrentLocationFailureState({required this.errorMsg});
}
final class GetCurrentLocationSuccessState extends DeliveryLocationState {}
final class GetCurrentLocationLoadingState extends DeliveryLocationState {}
