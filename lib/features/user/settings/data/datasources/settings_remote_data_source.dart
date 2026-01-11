import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/dio_consumer.dart';
import 'package:aslol/core/services/network/end_points.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/app/data/models/generic_model.dart';
import 'package:aslol/features/settings/data/models/settings_model.dart';

abstract class SettingsRemoteDataSource {
  Future<ApiSuccessResponse> sendSuggestionType(
      {required int id, String? other});

  Future<ApiSuccessResponse> getAllSuggestionType();

  Future<ApiSuccessResponse> getPageData({required int pageNumber});

  Future<ApiSuccessResponse> getFaqs();

  Future<ApiSuccessResponse> getAppSettings();

  Future<ApiSuccessResponse> getDeletionReasons();

  Future<ApiSuccessResponse> changeLangCode({required String langCode});
}

@LazySingleton(as: SettingsRemoteDataSource)
class SettingsRemoteDataSourceImpl implements SettingsRemoteDataSource {
  final DioConsumer dioConsumer;

  SettingsRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getAllSuggestionType() async {
    final response = await dioConsumer.get(path: EndPoints.suggestions);
    List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> sendSuggestionType(
      {required int id, String? other}) async {
    final response = await dioConsumer.post(
        path: EndPoints.sendSuggestion,
        body: {"suggestion_type_id": id, if (other != null) "message": other});
    return ApiSuccessResponse(message: response['message']);
  }

  @override
  Future<ApiSuccessResponse> getPageData({required int pageNumber}) async {
    final response =
        await dioConsumer.get(path: EndPoints.pages(pageNumber.toString()));
    return ApiSuccessResponse(data: GenericModel.fromJson(response['data']));
  }

  @override
  Future<ApiSuccessResponse> getFaqs() async {
    final response = await dioConsumer.get(path: EndPoints.faqQuestions);
    List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> getAppSettings() async {
    final response = await dioConsumer.get(path: EndPoints.appSettings);
    SettingsModel settingsModel = SettingsModel.fromJson(response['data']);
    return ApiSuccessResponse(data: settingsModel);
  }

  @override
  Future<ApiSuccessResponse> getDeletionReasons() async {
    final response = await dioConsumer.get(path: EndPoints.deletionReasons);
    List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> changeLangCode({required String langCode}) async {
    final response = await dioConsumer
        .post(path: EndPoints.language, body: {"lang": langCode});
    return ApiSuccessResponse();
  }
}
