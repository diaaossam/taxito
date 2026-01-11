import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/success_response.dart';
import '../../../../../core/services/network/end_points.dart';
import '../models/attribute_model.dart';
import '../models/sub_attribute_value_model.dart';

abstract class AttributesRemoteDataSource {
  Future<ApiSuccessResponse> getAttributes({required int pageKey});

  Future<ApiSuccessResponse> addAttribute({required Map<String, dynamic> body});

  Future<ApiSuccessResponse> updateAttribute({
    required num id,
    required Map<String, dynamic> body,
  });

  Future<ApiSuccessResponse> deleteAttribute({required num id});

  Future<ApiSuccessResponse> uploadSubAttribute({
    required Map<num, List<SubAttributeValueModel>> map,
  });
}

@LazySingleton(as: AttributesRemoteDataSource)
class AttributesRemoteDataSourceImpl implements AttributesRemoteDataSource {
  final DioConsumer dioConsumer;

  AttributesRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getAttributes({required int pageKey}) async {
    final response = await dioConsumer.get(
      path: EndPoints.supplierAttributes,
      params: {"page": pageKey},
    );
    final List<AttributeModel> list = (response['data'] as List)
        .map<AttributeModel>((e) => AttributeModel.fromJson(e))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> addAttribute({
    required Map<String, dynamic> body,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.supplierAttributes,
      body: body,
    );
    return ApiSuccessResponse(response: response, data: response['data']);
  }

  @override
  Future<ApiSuccessResponse> updateAttribute({
    required num id,
    required Map<String, dynamic> body,
  }) async {
    final response = await dioConsumer.put(
      path: "${EndPoints.supplierAttributes}/$id",
      body: body,
    );
    return ApiSuccessResponse(response: response, data: response['data']);
  }

  @override
  Future<ApiSuccessResponse> deleteAttribute({required num id}) async {
    final response = await dioConsumer.delete(
      path: "${EndPoints.supplierAttributes}/$id",
    );
    return ApiSuccessResponse(message: response['message'] ?? "");
  }

  @override
  Future<ApiSuccessResponse> uploadSubAttribute({
    required Map<num, List<SubAttributeValueModel>> map,
  }) async {
    for (final entry in map.entries) {
      final attributeId = entry.key;
      final valuesList = entry.value;

      for (final value in valuesList) {
        final response = await dioConsumer.post(
          path: "${EndPoints.supplierAttributes}/$attributeId/values",
          body: value.toJson(),
        );
      }
    }

    return ApiSuccessResponse();
  }
}
