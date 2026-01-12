import 'dart:convert';

import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxito/config/environment/environment_helper.dart' as env;
import 'package:uuid/uuid.dart';
import '../../../../../core/utils/api_config.dart';
import '../../../../captain/app/data/models/generic_model.dart';
import '../../../../captain/delivery_order/data/models/response/my_address.dart';
import '../models/requests/location_params.dart';
import '../models/response/location_details_model.dart';
import '../models/response/main_location_data.dart';
import '../models/response/suggestion_model.dart';

abstract class LocationRemoteDataSource {
  Future<ApiSuccessResponse> getGovernorates();

  Future<ApiSuccessResponse> getRegion({required num id});

  Future<ApiSuccessResponse> addNewAddress({
    required SavedLocationParams params,
    num? id,
  });

  Future<ApiSuccessResponse> getMyAddress();

  Future<ApiSuccessResponse> makeAddressDefault({required MyAddress myAddress});

  Future<ApiSuccessResponse> deleteAddress({required num id});

  Future<ApiSuccessResponse> fetchGoogleSuggestion({required String query});

  Future<ApiSuccessResponse> getPlaceDetailsByPlaceId({
    required SuggestionModel suggestionModel,
  });

  Future<ApiSuccessResponse> getPlaceDetailsByLatlng({required LatLng latlng});
}

@LazySingleton(as: LocationRemoteDataSource)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final DioConsumer dioConsumer;
  final SharedPreferences sharedPreferences;
  var uuid = const Uuid();

  LocationRemoteDataSourceImpl({
    required this.dioConsumer,
    required this.sharedPreferences,
  });

  @override
  Future<ApiSuccessResponse> fetchGoogleSuggestion({
    required String query,
  }) async {
    List<SuggestionModel> suggestions = [];
    final response = await dioConsumer.get(
      path: EndPoints.mapSuggestions,
      params: {
        'q': query,
        'access_token': env.Environment.googleApiKey,
        'session_token': uuid.v4(),
        "country": "IQ",
      },
    );
    suggestions = response['suggestions']
        .map<SuggestionModel>((element) => SuggestionModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: suggestions);
  }

  @override
  Future<ApiSuccessResponse> getPlaceDetailsByPlaceId({
    required SuggestionModel suggestionModel,
  }) async {
    final response = await dioConsumer.get(
      path: "${EndPoints.placeLocation}/${suggestionModel.mapboxId}",
      params: {
        'session_token': uuid.v4(),
        "access_token": env.Environment.googleApiKey,
      },
    );

    List<LocationDetailsModel> list = response['features']
        .map<LocationDetailsModel>(
          (element) => LocationDetailsModel.fromJson(element),
        )
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
  Future<ApiSuccessResponse> getPlaceDetailsByLatlng({
    required LatLng latlng,
  }) async {
    final response = await dioConsumer.get(
      path:
          "${EndPoints.addressBaseUrl}/${latlng.longitude},${latlng.latitude}.json",
      params: {"access_token": env.Environment.googleApiKey},
    );
    if (response['features'].isNotEmpty) {
      return ApiSuccessResponse(data: response['features'][0]['place_name']);
    } else {
      return ApiSuccessResponse(data: "Unknown location");
    }
  }

  @override
  Future<ApiSuccessResponse> getGovernorates() async {
    final response = await dioConsumer.get(
      path: EndPoints.provinces,
      body: {"perPage": 60},
    );
    final List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> getRegion({required num id}) async {
    final response = await dioConsumer.get(
      path: EndPoints.region,
      params: {"province_id": id, "perPage": 30},
    );
    final List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> addNewAddress({
    required SavedLocationParams params,
    num? id,
  }) async {
    if (id != null) {
      final response = await dioConsumer.put(
        path: "${EndPoints.addresses}/$id",
        body: params.toJson(),
      );
      return ApiSuccessResponse(message: response['message']);
    } else {
      final response = await dioConsumer.post(
        path: EndPoints.addresses,
        body: params.toJson(),
      );
      return ApiSuccessResponse(message: response['message']);
    }
  }

  @override
  Future<ApiSuccessResponse> getMyAddress() async {
    final response = await dioConsumer.get(path: EndPoints.addresses);
    List<MyAddress> list = [];
    response['data'].forEach((element) async {
      final data = MyAddress.fromJson(element);
      list.add(data);
      if (data.isDefault == true) {
        if (list.isNotEmpty) {
          sharedPreferences.setString(
            AppStrings.location,
            json.encode(list.first.toJson()),
          );
          await ApiConfig().init();
        }
      }
    });

    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> makeAddressDefault({
    required MyAddress myAddress,
  }) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.makeAddressDefault}/${myAddress.id}",
    );
    final String location = json.encode(myAddress.toJson());
    sharedPreferences.setString(AppStrings.location, location);
    await ApiConfig().init();
    return ApiSuccessResponse(message: response['message']);
  }

  @override
  Future<ApiSuccessResponse> deleteAddress({required num id}) async {
    final response = await dioConsumer.delete(
      path: "${EndPoints.addresses}/$id",
    );
    if (id == ApiConfig.myAddress?.id) {
      sharedPreferences.remove(AppStrings.location);
      await ApiConfig().init();
    }
    return ApiSuccessResponse(message: response['message']);
  }
}
