import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

abstract class AppRepository {
  Future<Either<Failure, String>> uploadImage({required File file});

  Future<Either<Failure, ApiSuccessResponse>> generateDeepLink(
      {required int id});

  Future<Either<Failure, ApiSuccessResponse>> deleteImage({required int id});
}
