import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/config/environment/environment_helper.dart' as env;
import 'package:uuid/uuid.dart';
import '../../../../../core/data/models/main_location_data.dart';
import '../../../../../core/services/network/dio_consumer.dart';
import '../../../../../core/services/network/end_points.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../app/data/models/generic_model.dart';
import '../models/location_details_model.dart';
import '../models/suggestion_model.dart';

abstract class LocationRemoteDataSource {
  Future<ApiSuccessResponse> getPlaceDetailsByPlaceId(
      {required SuggestionModel suggestionModel});

  Future<ApiSuccessResponse> getPlaceDetailsByLatlng({required LatLng latlng});

  Future<ApiSuccessResponse> getGovernorates();

  Future<ApiSuccessResponse> updateDriverLocation(
      {required num lat, required num lng});
}

@Injectable(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final DioConsumer dioConsumer;
  var uuid = const Uuid();

  LocationRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getPlaceDetailsByPlaceId({
    required SuggestionModel suggestionModel,
  }) async {
    final response = await dioConsumer.get(
        path: "${EndPoints.placeLocation}/${suggestionModel.mapboxId}",
        params: {
          'session_token': uuid.v4(),
          "access_token": env.Environment.googleApiKey
        });

    List<LocationDetailsModel> list = response['features']
        .map<LocationDetailsModel>(
            (element) => LocationDetailsModel.fromJson(element))
        .toList();

    LatLng latLng = LatLng(
      list.first.properties!.coordinates!.latitude!.toDouble(),
      list.first.properties!.coordinates!.longitude!.toDouble(),
    );
    ApiSuccessResponse result = await getPlaceDetailsByLatlng(latlng: latLng);
    String address = result.data;

    MainLocationData mainLocationData = MainLocationData(
      address: address,
      place: suggestionModel.placeFormatted ?? "",
      latLng: latLng,
    );
    return ApiSuccessResponse(data: mainLocationData);
  }

  @override
  Future<ApiSuccessResponse> getPlaceDetailsByLatlng(
      {required LatLng latlng}) async {
    final response = await dioConsumer.get(
        path:
            "${EndPoints.addressBaseUrl}/${latlng.longitude},${latlng.latitude}.json",
        params: {"access_token": env.Environment.googleApiKey});
    if (response['features'].isNotEmpty) {
      return ApiSuccessResponse(data: response['features'][0]['place_name']);
    } else {
      return ApiSuccessResponse(data: "Unknown location");
    }
  }

  @override
  Future<ApiSuccessResponse> getGovernorates() async {
    final response = await dioConsumer.get(path: EndPoints.governorates);
    final List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> updateDriverLocation(
      {required num lat, required num lng}) async {
    await dioConsumer.post(
        path: EndPoints.updateDriverLocation,
        body: {
          "latitude": lat,
          "longitude": lng,
          "address":"address"
        });
    return ApiSuccessResponse();
  }
}
