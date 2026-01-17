import 'package:taxito/core/enum/order_type.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_locale_data_source.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/cart_model.dart';
import '../models/promo_code_params.dart';

@LazySingleton(as: OrderRepository)
class OrderRepoImpl implements OrderRepository {
  final OrderLocaleDataSource orderLocaleDataSource;
  final OrderRemoteDataSource orderRemoteDataSource;

  OrderRepoImpl({
    required this.orderLocaleDataSource,
    required this.orderRemoteDataSource,
  });

  @override
  Future<Either<Failure, ApiSuccessResponse>> getOrderList({
    required int pageKey,
    OrderType? orderType,
  }) async {
    try {
      final response = await orderRemoteDataSource.getOrderList(
        pageKey: pageKey,
        orderType: orderType,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CartItem>>> getCartList({
    required bool isRemote,
  }) async {
    try {
      final response = await orderLocaleDataSource.getCartList(
        isRemote: isRemote,
      );
      return right(response);
    } catch (e) {
      return left(const CacheFailure(msg: "Caching Failure"));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteProductToCart({
    required List<CartItem> cartProductList,
    required String id,
  }) async {
    try {
      final response = await orderLocaleDataSource.deleteProductToCart(
        cartProductList: cartProductList,
        id: id,
      );
      return right(response);
    } catch (e) {
      return left(const CacheFailure(msg: "Caching Failure"));
    }
  }

  @override
  List<CartItem> setQuantity({
    required List<CartItem> cartProductList,
    required String productId,
    required bool isIncrease,
  }) {
    return orderLocaleDataSource.setQuantity(
      cartProductList: cartProductList,
      productId: productId,
      isIncrease: isIncrease,
    );
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> placeOrder({
    required CartModel placeOrderModel,
  }) async {
    try {
      final response = await orderRemoteDataSource.placeOrder(
        placeOrderModel: placeOrderModel,
      );
      await orderLocaleDataSource.clearCartUseCase();
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> addProductToCart({
    required List<CartItem> cartProductList,
  }) async {
    try {
      final response = await orderLocaleDataSource.addProductToCart(
        cartProductList: cartProductList,
      );
      return right(response);
    } catch (e) {
      return left(const CacheFailure(msg: "Caching Failure"));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> applyPromoCode({
    required PromoCodeParams params,
  }) async {
    try {
      final response = await orderRemoteDataSource.applyPromoCode(
        params: params,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getOrderDetails({
    required int id,
  }) async {
    try {
      final response = await orderRemoteDataSource.getOrderDetails(id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> deleteOrder({
    required num id,
  }) async {
    try {
      final response = await orderRemoteDataSource.deleteOrder(id: id);
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getLocationCost({
    required num supplierId,
  }) async {
    try {
      final response = await orderRemoteDataSource.getLocationCost(
        supplierId: supplierId,
      );
      return right(response);
    } catch (e) {
      return left(ServerFailure(msg: e.toString()));
    }
  }
}
