import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/dio_consumer.dart';
import 'package:aslol/core/services/network/end_points.dart';
import 'package:aslol/core/services/network/success_response.dart';

abstract class AppRemoteDataSource {
  Future<String> uploadImage({required File file});

  Future<ApiSuccessResponse> generateDeepLink({required int id});

  Future<ApiSuccessResponse> deleteImage({required int id});
}

@LazySingleton(as: AppRemoteDataSource)
class AppRemoteDataSourceImpl implements AppRemoteDataSource {
  final DioConsumer dioConsumer;

  AppRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<String> uploadImage({required File file}) async {
    final response = await dioConsumer.post(
        path: EndPoints.uploadImage,
        isFromData: true,
        body: {"media_files[]": await MultipartFile.fromFile(file.path)});
    return response['data'][0]['uuid'];
  }

  @override
  Future<ApiSuccessResponse> deleteImage({required int id}) async {
    final response = await dioConsumer.delete(
        path: "${EndPoints.deleteImage(id.toString())}");
    return ApiSuccessResponse(message: response['data']);
  }

  @override
  Future<ApiSuccessResponse> generateDeepLink({required int id}) async {
    return ApiSuccessResponse();
  }
}
