import 'dart:async';
import 'package:taxito/core/services/socket/socket.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/services/network/dio_consumer.dart';
import '../../../../../core/services/network/end_points.dart';
import '../../../../../core/services/network/success_response.dart';
import '../../domain/entities/send_chat_params.dart';
import '../models/message_model.dart';

const int chaPageSize = 10;

abstract class ChatsRemoteDataSource {
  Future<ApiSuccessResponse> sendChat({required SendChatParams sendChatParams});

  Future<ApiSuccessResponse> getChatMessages({required int pageKey});
}

@Injectable(as: ChatsRemoteDataSource)
class ChatsRemoteDataSourceImpl implements ChatsRemoteDataSource {
  final DioConsumer dioConsumer;
  final SocketService socketService;

  ChatsRemoteDataSourceImpl({
    required this.dioConsumer,
    required this.socketService,
  });

  @override
  Future<ApiSuccessResponse> sendChat({
    required SendChatParams sendChatParams,
  }) async {
    final response = await dioConsumer.post(
      path: EndPoints.supportChat,
      body: sendChatParams.toJson(),
    );
    MessageModel model = MessageModel.fromJson(response['data']);
    return ApiSuccessResponse(data: model);
  }

  @override
  Future<ApiSuccessResponse> getChatMessages({required int pageKey}) async {
    final data = await dioConsumer.get(path: EndPoints.supportChat);
    final response = await dioConsumer.get(
      path: "${EndPoints.supportChat}/${data['data']['id']}",
      params: {"page": pageKey, "perPage": chaPageSize},
    );
    final List<MessageModel> messages = response['data']
        .map<MessageModel>((element) => MessageModel.fromJson(element))
        .toList();
    return ApiSuccessResponse(data: messages);
  }
}
