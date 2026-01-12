import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/services/network/end_points.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/features/user/order/data/models/cart_model.dart';
import 'package:taxito/features/user/order/data/models/coupon_model.dart';
import 'package:taxito/core/data/models/orders.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/dio_consumer.dart';
import '../../../../../core/services/network/success_response.dart';
import 'package:taxito/core/data/models/product_model.dart';
import '../models/promo_code_params.dart';

abstract class OrderRemoteDataSource {
  Future<ApiSuccessResponse> placeOrder({required CartModel placeOrderModel});

  Future<ApiSuccessResponse> applyPromoCode({required PromoCodeParams params});

  Future<ApiSuccessResponse> getOrderList({
    required int pageKey,
    required OrderType orderType,
  });

  Future<ApiSuccessResponse> getOrderDetails({required int id});

  Future<ApiSuccessResponse> deleteOrder({required num id});

  Future<ApiSuccessResponse> getLocationCost({required num supplierId});

  Future<ApiSuccessResponse> checkProductAvilabilaty({
    required List<int> productIds,
  });
}

@LazySingleton(as: OrderRemoteDataSource)
class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final DioConsumer dioConsumer;

  OrderRemoteDataSourceImpl({required this.dioConsumer});

  @override
  Future<ApiSuccessResponse> placeOrder({
    required CartModel placeOrderModel,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.userOrders,
      body: placeOrderModel.toJson(),
    );
    return ApiSuccessResponse(data: response['data']['id']);
  }

  @override
  Future<ApiSuccessResponse> applyPromoCode({
    required PromoCodeParams params,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.validateCoupon,
      body: params.toJson(),
    );
    CouponModel couponModel = CouponModel.fromJson(response['data']);
    return ApiSuccessResponse(data: couponModel);
  }

  @override
  Future<ApiSuccessResponse> getOrderList({
    required int pageKey,
    required OrderType orderType,
  }) async {
    final response = await dioConsumer.get(
      path: EndPoints.userOrders,
      params: {"page": pageKey, "status": orderType.name},
    );
    final List<Orders> list = response['data']
        .map<Orders>((element) => Orders.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }

  @override
  Future<ApiSuccessResponse> getOrderDetails({required int id}) async {
    final response = await dioConsumer.get(path: "${EndPoints.userOrders}/$id");
    Orders orders = Orders.fromJson(response['data']);
    return ApiSuccessResponse(data: orders);
  }

  @override
  Future<ApiSuccessResponse> deleteOrder({required num id}) async {
    final response = await dioConsumer.post(
      path: "${EndPoints.cancelOrders}/$id",
    );
    return ApiSuccessResponse(message: response['message']);
  }

  @override
  Future<ApiSuccessResponse> getLocationCost({required num supplierId}) async {
    final response = await dioConsumer.get(
      path: EndPoints.shippingCosts,
      params: {
        "supplier_id": supplierId,
        "latitude": ApiConfig.myAddress?.lat,
        "longitude": ApiConfig.myAddress?.lng,
      },
    );
    return ApiSuccessResponse(data: response['data']['shipping_cost']);
  }

  @override
  Future<ApiSuccessResponse> checkProductAvilabilaty({
    required List<int> productIds,
  }) async {
    final body = {
      "products": productIds.map((e) => {"id": e}).toList(),
    };

    final response = await dioConsumer.post(
      path: EndPoints.checkProduct,
      body: body,
    );

    final List<ProductModel> list = response['data']
        .map<ProductModel>((element) => ProductModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: list);
  }
}
