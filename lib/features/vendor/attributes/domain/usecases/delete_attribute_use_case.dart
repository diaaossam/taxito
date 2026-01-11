import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../repositories/attributes_repository.dart';

@Injectable()
class DeleteAttributeUseCase {
  final AttributesRepository repository;

  DeleteAttributeUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call({required num id}) async {
    return await repository.deleteAttribute(id: id);
  }
}
