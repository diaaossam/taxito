import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/supplier/data/models/response/supplier_model.dart';
import 'package:injectable/injectable.dart';

import '../../../../captain/app/data/models/generic_model.dart';
import '../models/requests/suppliers_params.dart';

abstract class SuppliersRemoteDataSource {
  Future<ApiSuccessResponse> getSupplierCategory({
    required SuppliersParams params,
  });

  Future<ApiSuccessResponse> getSupplierDetailsCategory({required num id});
}

@LazySingleton(as: SuppliersRemoteDataSource)
class SuppliersRemoteDataSourceImpl implements SuppliersRemoteDataSource {
  final DioConsumer dioConsumer;

  SuppliersRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> getSupplierCategory({
    required SuppliersParams params,
  }) async {
    final Map<String, dynamic> queryParams = {
      "page": params.pageKey,
      if (params.search != null) "search": params.search,
    };

    if (params.supplierCategories != null) {
      for (var id in params.supplierCategories!) {
        queryParams.putIfAbsent("supplier_categories[]", () => []).add(id);
      }
    }
    final response = await dioConsumer.get(
      path: EndPoints.suppliers,
      params: queryParams,
    );
    final List<SupplierModel> list = response['data']
        .map<SupplierModel>((element) => SupplierModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> getSupplierDetailsCategory({
    required num id,
  }) async {
    final response = await dioConsumer.get(
      path: "${EndPoints.suppliers}/$id/categories",
    );
    final List<GenericModel> list = response['data']
        .map<GenericModel>((element) => GenericModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }
}
