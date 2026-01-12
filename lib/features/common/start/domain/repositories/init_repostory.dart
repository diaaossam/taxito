import 'package:dartz/dartz.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../../../../../core/services/network/error/failures.dart';

abstract class InitRepository {
  Future<Either<Failure, ApiSuccessResponse>> getIntroData();

  Future<Either<Failure, ApiSuccessResponse>> initUser();
}
