import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/user/main/domain/repositories/main_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class UpdateDeviceToken {
  final MainRepository repository;

  UpdateDeviceToken(this.repository);

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await repository.updateDeviceToken();
  }
}
