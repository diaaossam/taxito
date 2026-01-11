import 'package:aslol/features/location/data/models/requests/location_params.dart';
import 'package:aslol/features/location/data/models/response/my_address.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network/error/failures.dart';
import '../../../../core/services/network/success_response.dart';
import '../../domain/repositories/location_repository.dart';
import '../datasources/location_remote_data_source.dart';
import '../models/response/suggestion_model.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSource locationRemoteDataSource;

  LocationRepositoryImpl({
    required this.locationRemoteDataSource,
  });


  @override
  Future<Either<Failure, ApiSuccessResponse>> fetchGoogleSuggestion(
      {required String query}) async {
    try {
      final response =
      await locationRemoteDataSource.fetchGoogleSuggestion(query: query);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

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
  Future<Either<Failure, ApiSuccessResponse>> getRegion(
      {required num id}) async {
    try {
      final response = await locationRemoteDataSource.getRegion(id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> addNewAddress(
      {required SavedLocationParams params, num? id}) async {
    try {
      final response =
          await locationRemoteDataSource.addNewAddress(params: params, id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getMyAddress() async {
    try {
      final response = await locationRemoteDataSource.getMyAddress();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> makeAddressDefault(
      {required MyAddress myAddress}) async {
    try {
      final response = await locationRemoteDataSource.makeAddressDefault(
          myAddress: myAddress);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> deleteAddress(
      {required num id}) async {
    try {
      final response = await locationRemoteDataSource.deleteAddress(id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
