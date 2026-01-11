import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../../../../captain/app/data/models/generic_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<ApiSuccessResponse> getCategories({required int pageKey});

  Future<ApiSuccessResponse> addCategory({required Map<String, dynamic> body});

  Future<ApiSuccessResponse> updateCategory({
    required num id,
    required Map<String, dynamic> body,
  });

  Future<ApiSuccessResponse> deleteCategory({required num id});
}

@LazySingleton(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final DioConsumer dioConsumer;

  CategoriesRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getCategories({required int pageKey}) async {
    final response = await dioConsumer.get(
      path: EndPoints.supplierCategoriesV2,
    );
    final List<GenericModel> list = (response['data'] as List)
        .map<GenericModel>((e) => GenericModel.fromJson(e))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> addCategory({
    required Map<String, dynamic> body,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.supplierCategoriesV2,
      body: body,
    );
    return ApiSuccessResponse(response: response, data: response['data']);
  }

  @override
  Future<ApiSuccessResponse> updateCategory({
    required num id,
    required Map<String, dynamic> body,
  }) async {
    final response = await dioConsumer.put(
      path: "${EndPoints.supplierCategoriesV2}/$id",
      body: body,
    );
    return ApiSuccessResponse(response: response, data: response['data']);
  }

  @override
  Future<ApiSuccessResponse> deleteCategory({required num id}) async {
    final response = await dioConsumer.delete(
      path: "${EndPoints.supplierCategoriesV2}/$id",
    );
    return ApiSuccessResponse(message: response['message'] ?? "");
  }
}
