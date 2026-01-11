import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/features/captain/app/domain/repositories/app_repository.dart';

@Injectable()
class UploadImageUseCase {
  final AppRepository appRepository;

  UploadImageUseCase({required this.appRepository});

  Future<Either<Failure, String>> call({required File file}) async {
    return await appRepository.uploadImage(file: file);
  }
}
