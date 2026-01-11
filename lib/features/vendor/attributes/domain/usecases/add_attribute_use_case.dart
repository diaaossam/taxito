import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/core/services/network/error/failures.dart';
import 'package:taxito/core/services/network/success_response.dart';

import '../repositories/attributes_repository.dart';

@Injectable()
class AddAttributeUseCase {
  final AttributesRepository repository;

  AddAttributeUseCase({required this.repository});

  Future<Either<Failure, ApiSuccessResponse>> call({required Map<String, dynamic> body}) async {
    return await repository.addAttribute(body: body);
  }
}
