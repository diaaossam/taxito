import 'package:taxito/core/services/network/dio_consumer.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/end_points.dart';
import '../../../../../core/services/network/success_response.dart';
import 'package:taxito/features/common/models/product_model.dart';
import '../models/request/product_params.dart';
import '../models/request/add_product_params.dart';
import '../models/response/review_model.dart';

abstract class ProductRemoteDataSource {
  Future<ApiSuccessResponse> addProduct({required AddProductParams params});

  Future<ApiSuccessResponse> getProduct({required ProductParams params});

  Future<ApiSuccessResponse> getReview({required num id});

  Future<ApiSuccessResponse> getProductData({required num id});

  Future<ApiSuccessResponse> deleteProduct({required num id});
}

@Injectable(as: ProductRemoteDataSource)
class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final DioConsumer dioConsumer;

  ProductRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> addProduct({
    required AddProductParams params,
  }) async {
    final formData = await params.toFormData();
    final response = await dioConsumer.post(
      path: EndPoints.products,
      data: formData,
    );
    return ApiSuccessResponse(data: response['message']);
  }

  @override
  Future<ApiSuccessResponse> getProduct({required ProductParams params}) async {
    final response = await dioConsumer.get(
      path: EndPoints.products,
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
  Future<ApiSuccessResponse> getReview({required num id}) async {
    final response = await dioConsumer.get(
      path: "${EndPoints.products}/$id/reviews",
    );
    final List<ReviewModel> list = response['data']
        .map<ReviewModel>((element) => ReviewModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> deleteProduct({required num id}) async {
    final response = await dioConsumer.delete(
      path: "${EndPoints.products}/$id",
    );
    return ApiSuccessResponse(message: response['message']);
  }

  @override
  Future<ApiSuccessResponse> getProductData({required num id}) async {
    final response = await dioConsumer.get(path: "${EndPoints.products}/$id");
    return ApiSuccessResponse(data: ProductModel.fromJson(response['data']));
  }
}
