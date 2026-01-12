import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/order/domain/repositories/order_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/promo_code_params.dart';

@Injectable()
class ApplyPromoCodeUseCase {
  final OrderRepository orderRepository;

  ApplyPromoCodeUseCase({required this.orderRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required PromoCodeParams params}) async {
    return await orderRepository.applyPromoCode(params: params);
  }
}
