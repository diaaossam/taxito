import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../data/models/response/suggestion_model.dart';
import '../repositories/location_repository.dart';

@Injectable()
class GetPlaceDetailsByPlaceIdUseCase {
  final LocationRepository locationRepository;

  GetPlaceDetailsByPlaceIdUseCase({required this.locationRepository});

  Future<Either<Failure, ApiSuccessResponse>> call({
    required SuggestionModel suggestionModel,
  }) async {
    return await locationRepository.getPlaceDetailsByPlaceId(
      suggestionModel: suggestionModel,
    );
  }
}
