import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:taxito/features/captain/settings/domain/repositories/settings_repository.dart';

@LazySingleton()
class GetAppSettingsUseCase {
  final SettingsRepository settingsRepository;

  GetAppSettingsUseCase({required this.settingsRepository});

  Future<Either<Failure, ApiSuccessResponse>> call() async {
    return await settingsRepository.getAppSettings();
  }
}
