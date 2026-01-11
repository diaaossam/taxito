import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/services/network/error/failures.dart';
import '../../../../core/services/network/success_response.dart';
import '../repositories/location_repository.dart';

@Injectable()
class GetGoogleSuggestUseCase {
  final LocationRepository locationRepository;

  GetGoogleSuggestUseCase({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required String query}) async {
    return await locationRepository.fetchGoogleSuggestion(query: query);
  }
}
