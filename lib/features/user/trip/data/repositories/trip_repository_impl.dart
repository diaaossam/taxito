import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../domain/entities/review_trip_params.dart';
import '../../domain/entities/trip_params.dart';
import '../../domain/repositories/trip_repository.dart';
import '../datasources/trip_remote_data_source.dart';
import '../models/trip_model.dart';

@Injectable(as: TripRepository)
class TripRepositoryImpl implements TripRepository {
  final TripRemoteDataSource tripRemoteDataSource;

  TripRepositoryImpl({required this.tripRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> requestTrip({
    required TripParams tripParams,
  }) async {
    try {
      final response = await tripRemoteDataSource.requestTrip(
        tripParams: tripParams,
      );
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> cancelTrip({
    required num id,
  }) async {
    try {
      final response = await tripRemoteDataSource.cancelTrip(id: id);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> reportIssue({
    required String msg,
    required TripModel tripModel,
  }) async {
    try {
      final response = await tripRemoteDataSource.reportIssue(
        msg: msg,
        tripModel: tripModel,
      );
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> sendTripReview({
    required ReviewTripParams reviewParams,
  }) async {
    try {
      final response = await tripRemoteDataSource.sendTripReview(
        reviewParams: reviewParams,
      );
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> sendPaymentUserRequest({
    required num id,
    required String paymentMethod,
  }) async {
    try {
      final response = await tripRemoteDataSource.sendPaymentUserRequest(
        id: id,
        paymentMethod: paymentMethod,
      );
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> validateCoupon({
    required String discountCode,
  }) async {
    try {
      final response = await tripRemoteDataSource.validateCoupon(
        discountCode: discountCode,
      );
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getUserDriver({
    required LatLng lat,
    required double radius,
  }) async {
    try {
      final response = await tripRemoteDataSource.getUserDriver(
        lat: lat,
        radius: radius,
      );
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getTripByUuid({
    required String uuid,
  }) async {
    try {
      final response = await tripRemoteDataSource.getTripByUuid(uuid: uuid);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getTripById({
    required num id,
  }) async {
    try {
      final response = await tripRemoteDataSource.getTripById(id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getAllTrips({
    required String status,
    required int pageKey,
    required bool isSch,
  }) async {
    try {
      final response = await tripRemoteDataSource.getAllTrips(
        status: status,
        pageKey: pageKey,
        isSch: isSch,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> searchTrip({
    required num tripId,
  }) async {
    try {
      final response = await tripRemoteDataSource.searchTrip(tripId: tripId);
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }
}
