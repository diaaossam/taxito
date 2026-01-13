import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/main/data/models/banners_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

abstract class MainRemoteDataSource {
  Future<ApiSuccessResponse> getAllBanners();

  Future<ApiSuccessResponse> getMainCategories();

  Future<ApiSuccessResponse> updateDeviceToken();
}

@LazySingleton(as: MainRemoteDataSource)
class MainRemoteDataSourceImpl implements MainRemoteDataSource {
  final DioConsumer dioConsumer;

  MainRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getAllBanners() async {
    final response = await dioConsumer.get(path: EndPoints.sliders);
    final res = response['data']
        .map<BannersModel>((element) => BannersModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: res as List<BannersModel>);
  }

  @override
  Future<ApiSuccessResponse> getMainCategories() async {
    final response = await dioConsumer.get(path: EndPoints.categories);
    final res = response['data'].map<BannersModel>((element) {
      return BannersModel.fromJson(element);
    }).toList();
    return ApiSuccessResponse(data: res as List<BannersModel>);
  }

  @override
  Future<ApiSuccessResponse> updateDeviceToken() async {
    final String? token = await FirebaseMessaging.instance.getToken();
    final response = await dioConsumer.post(
      path: EndPoints.updateFcm,
      body: {"device_token": token},
    );
    return ApiSuccessResponse();
  }
}
