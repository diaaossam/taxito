import 'package:dartz/dartz.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../../../../../core/services/network/error/failures.dart';

abstract class DriverMainRepository {
  Future<Either<Failure, ApiSuccessResponse>> toggleAvailitiablity();
}
