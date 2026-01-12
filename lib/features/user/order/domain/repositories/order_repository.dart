import 'package:taxito/core/enum/order_type.dart';
import 'package:dartz/dartz.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../data/models/cart_model.dart';
import '../../data/models/promo_code_params.dart';

abstract class OrderRepository {
  Future<Either<Failure, bool>> addProductToCart({
    required List<CartItem> cartProductList,
  });

  Future<Either<Failure, bool>> deleteProductToCart({
    required List<CartItem> cartProductList,
    required String id,
  });

  Future<Either<Failure, ApiSuccessResponse>> getOrderList({
    required OrderType orderType,
    required int pageKey,
  });

  Future<Either<Failure, List<CartItem>>> getCartList({required bool isRemote});

  List<CartItem> setQuantity({
    required List<CartItem> cartProductList,
    required String productId,
    required bool isIncrease,
  });

  Future<Either<Failure, ApiSuccessResponse>> placeOrder({
    required CartModel placeOrderModel,
  });

  Future<Either<Failure, ApiSuccessResponse>> applyPromoCode({
    required PromoCodeParams params,
  });

  Future<Either<Failure, ApiSuccessResponse>> getOrderDetails({
    required int id,
  });

  Future<Either<Failure, ApiSuccessResponse>> deleteOrder({required num id});

  Future<Either<Failure, ApiSuccessResponse>> getLocationCost({
    required num supplierId,
  });
}
