import 'package:dartz/dartz.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';

abstract class DriverMainRepository {
  Future<Either<Failure, ApiSuccessResponse>> toggleAvailitiablity();
}
