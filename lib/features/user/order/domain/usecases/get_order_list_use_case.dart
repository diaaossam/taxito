import 'package:aslol/core/enum/order_type.dart';
import 'package:aslol/features/order/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network/error/failures.dart';
import '../../../../core/services/network/success_response.dart';

@LazySingleton()
class GetOrderListUseCase {
  final OrderRepository orderRepository;

  GetOrderListUseCase({required this.orderRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required int pageKey, required OrderType orderType}) async {
    return await orderRepository.getOrderList(
        orderType: orderType, pageKey: pageKey);
  }
}
