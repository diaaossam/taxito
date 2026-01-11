import 'package:dartz/dartz.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../../data/models/sub_attribute_value_model.dart';

abstract class AttributesRepository {
  Future<Either<Failure, ApiSuccessResponse>> getAttributes(
      {required int page});

  Future<Either<Failure, ApiSuccessResponse>> addAttribute(
      {required Map<String, dynamic> body});

  Future<Either<Failure, ApiSuccessResponse>> updateAttribute(
      {required num id, required Map<String, dynamic> body});

  Future<Either<Failure, ApiSuccessResponse>> deleteAttribute(
      {required num id});

  Future<Either<Failure, ApiSuccessResponse>> uploadSubAttribute(
      {required Map<num, List<SubAttributeValueModel>> map});
}
