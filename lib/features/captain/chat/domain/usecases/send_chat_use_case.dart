import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/success_response.dart';
import '../entities/send_chat_params.dart';
import '../repositories/chats_repoitory.dart';

@Injectable()
class SendChatUseCase {
  final ChatsRepository chatsRepository;

  SendChatUseCase({required this.chatsRepository});

  Future<Either<Failure, ApiSuccessResponse>> call(
      {required SendChatParams sendChatParams}) async {
    return await chatsRepository.sendChat(sendChatParams: sendChatParams);
  }
}
