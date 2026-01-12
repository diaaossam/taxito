import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/order/data/models/product_params.dart';
import 'package:taxito/features/user/product/data/models/favoutrite_response.dart';
import 'package:injectable/injectable.dart';
import '../../../supplier/data/models/response/supplier_model.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<ApiSuccessResponse> toggleWishlist({
    required num id,
    required String type,
  });

  Future<ApiSuccessResponse> getProducts({required ProductParams params});

  Future<ApiSuccessResponse> getProductDetails({
    required num id,
    required num supplierId,
  });

  Future<ApiSuccessResponse> submitReview({required Map<String, dynamic> map});

  Future<ApiSuccessResponse> getFavourite({
    required int pageKey,
    required int type,
  });

  Future<ApiSuccessResponse> getSuppliersProduct({
    required ProductParams params,
  });
}

@LazySingleton(as: ProductRemoteDataSource)
class ProductRemoteDatasourceImpl implements ProductRemoteDataSource {
  final DioConsumer dioConsumer;

  ProductRemoteDatasourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> toggleWishlist({
    required num id,
    required String type,
  }) async {
    final response = await dioConsumer.put(
      path: "${EndPoints.favourites}/$id",
      body: {"type": type},
    );
    return ApiSuccessResponse(message: response['message']);
  }

  @override
  Future<ApiSuccessResponse> getProducts({
    required ProductParams params,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.userProducts,
      body: params.toJson(),
    );

    final List<ProductModel> list = response['data'].map<ProductModel>((
      element,
    ) {
      return ProductModel.fromJson(element);
    }).toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> getProductDetails({
    required num id,
    required num supplierId,
  }) async {
    final response = await dioConsumer.get(
      path: "${EndPoints.suppliers}/$supplierId/products/$id",
    );
    ProductModel productModel = ProductModel.fromJson(response['data']);
    return ApiSuccessResponse(data: productModel);
  }

  @override
  Future<ApiSuccessResponse> submitReview({
    required Map<String, dynamic> map,
  }) async {
    if (map.containsKey("data")) {
      map['rate_type'] = "product";
    }

    final response = await dioConsumer.post(
      path: "${EndPoints.rateOrder}/${map['id']}",
      body: map,
    );
    return ApiSuccessResponse(data: response['message']);
  }

  @override
  Future<ApiSuccessResponse> getFavourite({
    required int pageKey,
    required int type,
  }) async {
    final response = await dioConsumer.get(
      path: EndPoints.favourites,
      body: {"page": pageKey, "type": type == 1 ? "product" : "supplier"},
    );

    final List<FavouriteResponse> list = response['data']
        .map<FavouriteResponse>((element) {
          FavouriteResponse favouriteResponse;
          if (type == 1) {
            favouriteResponse = FavouriteResponse(
              type: type,
              productModel: ProductModel.fromJson(element),
            );
          } else {
            favouriteResponse = FavouriteResponse(
              type: type,
              supplierModel: SupplierModel.fromJson(element),
            );
          }
          return favouriteResponse;
        })
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> getSuppliersProduct({
    required ProductParams params,
  }) async {
    final response = await dioConsumer.get(
      path: "${EndPoints.suppliers}/${params.supplierId}/products",
      params: {
        "page": params.pageKey,
        if (params.productCategoryId != null)
          "product_category_id": params.productCategoryId,
      },
    );

    final List<ProductModel> list = response['data'].map<ProductModel>((
      element,
    ) {
      return ProductModel.fromJson(element);
    }).toList();
    return ApiSuccessResponse(data: list);
  }
}
