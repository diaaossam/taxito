import 'package:dartz/dartz.dart';

import '../../../../../core/enum/trip_status_enum.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../data/models/trip_model.dart';

abstract class DriverTripRepository {
  Future<Either<Failure, ApiSuccessResponse>> getTripById({
    required num id,
  });

  Future<Either<Failure, ApiSuccessResponse>> acceptTrip({required num tripId});
  Future<Either<Failure, ApiSuccessResponse>> rejectTrip({required num tripId});

  Future<Either<Failure, ApiSuccessResponse>> cancelTrip(
      {required TripModel tripModel});

  Future<Either<Failure, ApiSuccessResponse>> endTrip(
      {required TripModel tripModel});

  Future<Either<Failure, ApiSuccessResponse>> getAllTrips(
      {required String status, required int pageKey});

  Future<Either<Failure, ApiSuccessResponse>> acceptDriverPaymentRequest(
      {required num id,required bool driverAcceptConfirmation});

  Future<Either<Failure, ApiSuccessResponse>> updateStatus(
      {required num id, required TripStatusEnum status});

  Future<Either<Failure,ApiSuccessResponse>> getPendingTrips();
}
