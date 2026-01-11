part of 'message_bloc.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}
final class ChangeUserTypingState extends MessageState {}
class GetChatMessagesSuccess extends MessageState {}
class SendMessageLoading extends MessageState {}
class SendMessageSuccess extends MessageState {
  final MessageModel model;

  SendMessageSuccess({required this.model});
}
class SendMessageFailure extends MessageState {
  final String errorMsg;

  SendMessageFailure({required this.errorMsg});
}
class ReceiveMessageSuccessState extends MessageState {
  final List<MessageModel> list;

  ReceiveMessageSuccessState({required this.list});
}

