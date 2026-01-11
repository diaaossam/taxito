import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/services/socket/socket.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../trip/data/models/trip_model.dart';
import '../../../data/models/message_model.dart';
import '../../../domain/entities/send_chat_params.dart';
import '../../../domain/usecases/get_chat_message_use_case.dart';
import '../../../domain/usecases/send_chat_use_case.dart';

part 'message_state.dart';

@injectable
class MessageBloc extends Cubit<MessageState> {
  final SendChatUseCase sendChatUseCase;
  final GetChatMessagesUseCase getChatMessagesUseCase;
  final SharedPreferences sharedPreferences;
  final PagingController<int, MessageModel> pagingController =
      PagingController(firstPageKey: 1);
  final SocketService socketService;
  String chatUUid = "";

  MessageBloc(
    this.sendChatUseCase,
    this.getChatMessagesUseCase,
    this.socketService,
    this.sharedPreferences,
  ) : super(MessageInitial());

  Future<void> sendNewMessage(
      {required SendChatParams params, String? loading}) async {
    emit(SendMessageLoading());
    final response = await sendChatUseCase(sendChatParams: params);
    response.fold(
      (l) => emit(SendMessageFailure(errorMsg: l.msg)),
      (r) {
        if (r.data != null) {
          if (!isClosed) {
            pagingController.itemList?.insert(0, r.data);
            emit(SendMessageSuccess(model: r.data));
          }
        }
      },
    );
  }

  Future<void> initSocketEvents(
      {required TripModel tripModel, required bool isSupport}) async {
    if (isSupport) {
      return;
    }
    chatUUid = tripModel.uuid ?? "";
    sharedPreferences.setBool(AppStrings.notifications, true);
    socketService.emitEvent("addUserToRoom", {
      "chat_uuid": tripModel.uuid,
    });
    socketService.onEvent("newMessage.${tripModel.uuid}", (data) {
      Map<String, dynamic> body = data;
      MessageModel message = MessageModel.fromJson(body);
      if (!pagingController.itemList!.contains(message)) {
        pagingController.itemList!.insert(0, message);
      }
      if (!isClosed) {
        emit(ReceiveMessageSuccessState(list: pagingController.itemList ?? []));
      }
    });
  }

  Future<void> fetchPage(
      {required int pageKey, required TripModel tripModel}) async {
    try {
      final newItems = await _getChats(pageKey: pageKey, tripModel: tripModel);
      final isLastPage = newItems.length < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<List<MessageModel>> _getChats(
      {required int pageKey, required TripModel tripModel}) async {
    List<MessageModel> messageList = [];
    final response =
        await getChatMessagesUseCase(tripModel: tripModel, pageKey: pageKey);
    response.fold((l) {
      messageList = [];
    }, (r) {
      messageList = r.data as List<MessageModel>;
    });
    return messageList;
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    socketService.disconnectFromRoom(chatUUid);
    return super.close();
  }
}
