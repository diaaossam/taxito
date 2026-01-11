import 'package:dartz/dartz.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';

abstract class LocationRepository {
  Future<Either<Failure, ApiSuccessResponse>> getGovernorates();

  Future<Either<Failure, ApiSuccessResponse>> getRegion({required num id});
}
