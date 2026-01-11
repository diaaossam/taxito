import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/app/domain/repositories/app_repository.dart';

@Injectable()
class DeleteImageUseCase {
  final AppRepository appRepository;

  DeleteImageUseCase({required this.appRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({required int id}) async {
    return await appRepository.deleteImage(id: id);
  }
}
