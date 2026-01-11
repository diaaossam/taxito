import 'package:dartz/dartz.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/main/domain/repositories/main_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class GetBannersUseCase {
  final MainRepository mainRepository;

  GetBannersUseCase({required this.mainRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return mainRepository.getAllBanners();
  }
}
