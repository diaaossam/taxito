import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_local_data_source.dart';
import '../datasources/location_remote_data_source.dart';
import '../models/suggestion_model.dart';

@Injectable(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource;
  final LocationLocalDataSource locationLocalDataSource;

  LocationRepositoryImpl(
      {required this.locationRemoteDataSource,
      required this.locationLocalDataSource});

  @override
  Future<Either<Failure, ApiSuccessResponse>> getPlaceDetailsByPlaceId(
      {required SuggestionModel suggestionModel}) async {
    try {
      final response = await locationRemoteDataSource.getPlaceDetailsByPlaceId(
          suggestionModel: suggestionModel);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getPlaceDetailsByLatlng(
      {required LatLng latlng}) async {
    try {
      final response = await locationRemoteDataSource.getPlaceDetailsByLatlng(
          latlng: latlng);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getGovernorates() async {
    try {
      final response = await locationRemoteDataSource.getGovernorates();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> updateDriverLocation(
      {required num lat, required num lng}) async {
    try {
      final response = await locationRemoteDataSource.updateDriverLocation(
          lat: lat, lng: lng);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }


}
