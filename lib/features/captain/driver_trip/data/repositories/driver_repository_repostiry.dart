import 'package:taxito/core/enum/trip_status_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/data/models/trip_model.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../domain/repositories/driver_repository.dart';
import '../datasources/driver_trip_remote_data_source.dart';

@Injectable(as: DriverTripRepository)
class DriverRepositoryRepository implements DriverTripRepository {
  final DriverTripRemoteDataSource driverTripRemoteDataSource;

  DriverRepositoryRepository({required this.driverTripRemoteDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getTripById({
    required num id,
  }) async {
    try {
      final response = await driverTripRemoteDataSource.getTripById(id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> acceptTrip({
    required num tripId,
  }) async {
    try {
      final response = await driverTripRemoteDataSource.acceptTrip(
        tripId: tripId,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> cancelTrip({
    required TripModel tripModel,
  }) async {
    try {
      final response = await driverTripRemoteDataSource.cancelTrip(
        tripModel: tripModel,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getAllTrips({
    required String status,
    required int pageKey,
  }) async {
    try {
      final response = await driverTripRemoteDataSource.getAllTrips(
        status: status,
        pageKey: pageKey,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> endTrip({
    required TripModel tripModel,
  }) async {
    try {
      final response = await driverTripRemoteDataSource.endTrip(
        tripModel: tripModel,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> acceptDriverPaymentRequest({
    required num id,
    required bool driverAcceptConfirmation,
  }) async {
    try {
      final response = await driverTripRemoteDataSource
          .acceptDriverPaymentRequest(
            id: id,
            driverAcceptConfirmation: driverAcceptConfirmation,
          );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> updateStatus({
    required num id,
    required TripStatusEnum status,
  }) async {
    try {
      final response = await driverTripRemoteDataSource.updateStatus(
        id: id,
        status: status,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> rejectTrip({
    required num tripId,
  }) async {
    try {
      final response = await driverTripRemoteDataSource.rejectTrip(
        tripId: tripId,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getPendingTrips() async {
    try {
      final response = await driverTripRemoteDataSource.getPendingTrips();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
