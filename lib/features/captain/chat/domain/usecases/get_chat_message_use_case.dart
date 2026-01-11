import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../../driver_trip/data/models/trip_model.dart';
import '../repositories/chats_repoitory.dart';

@Injectable()
class GetChatMessagesUseCase {
  final ChatsRepository chatsRepository;

  GetChatMessagesUseCase({required this.chatsRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required int pageKey, required TripModel tripModel}) async {
    return await chatsRepository.getChatMessages(
        pageKey: pageKey, tripModel: tripModel);
  }
}
