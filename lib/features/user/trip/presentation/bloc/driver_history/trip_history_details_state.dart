part of 'trip_history_details_cubit.dart';

@immutable
sealed class TripHistoryDetailsState {}

final class TripHistoryDetailsInitial extends TripHistoryDetailsState {}
final class InitHistoryTripDetailsState extends TripHistoryDetailsState {}
