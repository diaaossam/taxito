import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/error/failures.dart';
import '../../../../../core/services/network/internet_checker/netwok_info.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../domain/entities/send_chat_params.dart';
import '../../domain/repositories/chats_repoitory.dart';
import '../datasources/chats_remote_data_source.dart';

@Injectable(as: ChatsRepository)
class ChatsRepositoryImpl implements ChatsRepository {
  final ChatsRemoteDataSource chatsRemoteDataSource;
  final NetworkInfo networkInfo;

  ChatsRepositoryImpl({
    required this.chatsRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ApiSuccessResponse>> sendChat({
    required SendChatParams sendChatParams,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await chatsRemoteDataSource.sendChat(
          sendChatParams: sendChatParams,
        );
        return right(response);
      } catch (error) {
        return left(ServerFailure(msg: error.toString()));
      }
    } else {
      return left(const ServerFailure(msg: ""));
    }
  }

  @override
  Future<Either<Failure, ApiSuccessResponse>> getChatMessages({
    required int pageKey,
  }) async {
    try {
      final response = await chatsRemoteDataSource.getChatMessages(
        pageKey: pageKey,
      );
      return right(response);
    } catch (error) {
      return left(ServerFailure(msg: error.toString()));
    }
  }
}
