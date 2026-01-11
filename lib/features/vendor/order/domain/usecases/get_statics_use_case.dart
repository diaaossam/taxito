import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../repositories/delivery_orders_repository.dart';

@LazySingleton()
class GetStaticsUseCase {
  final DeliveryOrdersRepository deliveryOrdersRepository;

  GetStaticsUseCase({required this.deliveryOrdersRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await deliveryOrdersRepository.getStatics();
  }
}
