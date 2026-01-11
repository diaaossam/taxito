import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/captain/app/data/models/generic_model.dart';
import 'package:taxito/features/captain/settings/data/models/settings_model.dart';

abstract class SettingsRemoteDataSource {
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
