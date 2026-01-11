import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/services/network/success_response.dart';
import '../models/suggestion_model.dart';

abstract class LocationLocalDataSource {
  Future<ApiSuccessResponse> cacheLocation(
      {required List<SuggestionModel> savedLocationList});

  Future<ApiSuccessResponse> deleteCachedLocation(
      {required List<SuggestionModel> savedLocationList, required String id});

  Future<ApiSuccessResponse> getCachedLocation();
}

@Injectable(as: LocationLocalDataSource)
class LocationLocalDataSourceImpl implements LocationLocalDataSource {
  final SharedPreferences sharedPreferences;

  LocationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ApiSuccessResponse> cacheLocation(
      {required List<SuggestionModel> savedLocationList}) async {
    List<String> locationList = [];
    for (var location in savedLocationList) {
      final json = jsonEncode(location.toJson());
      locationList.add(json);
    }
    sharedPreferences.setStringList("locations", locationList);
    return ApiSuccessResponse(data: true);
  }

  @override
  Future<ApiSuccessResponse> deleteCachedLocation(
      {required List<SuggestionModel> savedLocationList,
      required String id}) async {
    savedLocationList.removeWhere((item) => item.mapboxId == id);
    List<String> locationList = [];
    for (var location in savedLocationList) {
      locationList.add(jsonEncode(location));
    }
    sharedPreferences.setStringList("locations", locationList);
    return ApiSuccessResponse(data: true);
  }

  @override
  Future<ApiSuccessResponse> getCachedLocation() async {
    List<String> savedLocationString = [];
    if (sharedPreferences.containsKey("locations")) {
      savedLocationString = sharedPreferences.getStringList("locations") ?? [];
    }
    List<SuggestionModel> savedLocation = [];
    for (var model in savedLocationString) {
      savedLocation.add(SuggestionModel.fromJson(jsonDecode(model)));
    }
    return ApiSuccessResponse(data: savedLocation);
  }
}
