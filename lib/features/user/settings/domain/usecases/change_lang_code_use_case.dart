import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:aslol/core/services/network/error/failures.dart';
import 'package:aslol/core/services/network/success_response.dart';
import 'package:aslol/features/settings/domain/repositories/settings_repository.dart';

@LazySingleton()
class ChangeLangCodeUseCase {
  final SettingsRepository settingsRepository;

  ChangeLangCodeUseCase({required this.settingsRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required String langCode}) async {
    return await settingsRepository.changeLangCode(langCode: langCode);
  }
}
