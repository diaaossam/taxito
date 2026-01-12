import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/common/start/domain/repositories/init_repostory.dart';

@LazySingleton()
class GetIntroDataUseCase {
  final InitRepository initRepository;

  GetIntroDataUseCase({required this.initRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await initRepository.getIntroData();
  }
}
