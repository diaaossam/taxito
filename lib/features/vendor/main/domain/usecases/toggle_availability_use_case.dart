import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../repositories/main_repository.dart';

@injectable
class ToggleAvailabilityUseCase {
  final DriverMainRepository mainRepository;

  ToggleAvailabilityUseCase({required this.mainRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await mainRepository.toggleAvailitiablity();
  }
}
