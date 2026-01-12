import 'package:taxito/features/user/location/data/models/requests/location_params.dart';
import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../../captain/delivery_order/data/models/response/my_address.dart';
import '../../data/models/response/suggestion_model.dart';

abstract class LocationRepository {
  Future<Either<Failure, ApiSuccessResponse>> getGovernorates();

  Future<Either<Failure, ApiSuccessResponse>> getRegion({required num id});

  Future<Either<Failure, ApiSuccessResponse>> addNewAddress({
    required SavedLocationParams params,
    num? id,
  });

  Future<Either<Failure, ApiSuccessResponse>> getMyAddress();

  Future<Either<Failure, ApiSuccessResponse>> makeAddressDefault({
    required MyAddress myAddress,
  });

  Future<Either<Failure, ApiSuccessResponse>> deleteAddress({required num id});

  Future<Either<Failure, ApiSuccessResponse>> fetchGoogleSuggestion({
    required String query,
  });

  Future<Either<Failure, ApiSuccessResponse>> getPlaceDetailsByPlaceId({
    required SuggestionModel suggestionModel,
  });

  Future<Either<Failure, ApiSuccessResponse>> getPlaceDetailsByLatlng({
    required LatLng latlng,
  });
}
