part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class GetUserDataEvent extends ProfileEvent {
  final num? userId;

  GetUserDataEvent({this.userId});
}

class BlockUserEvent extends ProfileEvent {
  final num userId;

  BlockUserEvent({required this.userId});
}

class SendInterestToUserEvent extends ProfileEvent {
  final num userId;

  SendInterestToUserEvent({required this.userId});
}

class ReplyMyInterestEvent extends ProfileEvent {
  final num orderId;
  final num userId;
  final bool isAccept;

  ReplyMyInterestEvent(
      {required this.userId, required this.orderId, required this.isAccept});
}

class GenerateDeepLinkEvent extends ProfileEvent {
  final num userId;

  GenerateDeepLinkEvent({required this.userId});
}
