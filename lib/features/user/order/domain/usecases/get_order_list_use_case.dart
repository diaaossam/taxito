import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/features/user/order/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';

@LazySingleton()
class GetOrderListUseCase {
  final OrderRepository orderRepository;

  GetOrderListUseCase({required this.orderRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required int pageKey,
    OrderType? orderType,
  }) async {
    return await orderRepository.getOrderList(
      orderType: orderType,
      pageKey: pageKey,
    );
  }
}
