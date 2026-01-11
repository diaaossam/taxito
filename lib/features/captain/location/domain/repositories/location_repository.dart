import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../data/models/suggestion_model.dart';

abstract class LocationRepository {
  Future<Either<Failure, ApiSuccessResponse>> getPlaceDetailsByPlaceId(
      {required SuggestionModel suggestionModel});

  Future<Either<Failure, ApiSuccessResponse>> getPlaceDetailsByLatlng(
      {required LatLng latlng});

  Future<Either<Failure, ApiSuccessResponse>> getGovernorates();

  Future<Either<Failure, ApiSuccessResponse>> updateDriverLocation(
      {required num lat, required num lng});
}
