import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../common/models/trip_model.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../entities/review_trip_params.dart';
import '../entities/trip_params.dart';

abstract class TripRepository {
  Future<Either<Failure, ApiSuccessResponse>> requestTrip({
    required TripParams tripParams,
  });

  Future<Either<Failure, ApiSuccessResponse>> cancelTrip({required num id});

  Future<Either<Failure, ApiSuccessResponse>> reportIssue({
    required String msg,
    required TripModel tripModel,
  });

  Future<Either<Failure, ApiSuccessResponse>> sendTripReview({
    required ReviewTripParams reviewParams,
  });

  Future<Either<Failure, ApiSuccessResponse>> sendPaymentUserRequest({
    required num id,
    required String paymentMethod,
  });

  Future<Either<Failure, ApiSuccessResponse>> validateCoupon({
    required String discountCode,
  });

  Future<Either<Failure, ApiSuccessResponse>> getUserDriver({
    required LatLng lat,
    required double radius,
  });

  Future<Either<Failure, ApiSuccessResponse>> getTripByUuid({
    required String uuid,
  });

  Future<Either<Failure, ApiSuccessResponse>> getTripById({required num id});

  Future<Either<Failure, ApiSuccessResponse>> getAllTrips({
    required String status,
    required int pageKey,
    required bool isSch,
  });

  Future<Either<Failure, ApiSuccessResponse>> searchTrip({required num tripId});
}
