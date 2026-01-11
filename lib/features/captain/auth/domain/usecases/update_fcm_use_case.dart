import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/auth_repository.dart';

@Injectable()
class UpdateFcmUseCase {
  final AuthRepository _authRepository;

  UpdateFcmUseCase(this._authRepository);

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await _authRepository.updateFcm();
  }
}
