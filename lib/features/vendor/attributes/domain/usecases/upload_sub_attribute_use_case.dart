import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/sub_attribute_value_model.dart';
import '../repositories/attributes_repository.dart';

@LazySingleton()
class UploadSubAttributeUseCase {
  final AttributesRepository attributesRepository;

  UploadSubAttributeUseCase({required this.attributesRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required Map<num, List<SubAttributeValueModel>> map,
  }) async {
    return await attributesRepository.uploadSubAttribute(map: map);
  }
}
