part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class GetAllNotificationsLoading extends NotificationsState {}

class GetAllNotificationsSuccess extends NotificationsState {
  final List<NotificationModel> list;

  const GetAllNotificationsSuccess({required this.list});

  @override
  List<Object> get props => [list];
}

class GetAllNotificationsFailure extends NotificationsState {
  final String errorMsg;

  const GetAllNotificationsFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class MarkAllNotificationAsReadLoading extends NotificationsState {}

class MarkAllNotificationAsReadSuccess extends NotificationsState {}

class MarkAllNotificationAsReadFailure extends NotificationsState {
  final String errorMsg;

  const MarkAllNotificationAsReadFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}



class GetCountNotificationsLoading extends NotificationsState {}

class GetCountNotificationsSuccess extends NotificationsState {
  final num count;

  const GetCountNotificationsSuccess({required this.count});

  @override
  List<Object> get props => [count];
}

class GetCountNotificationsFailure extends NotificationsState {
  final String errorMsg;

  const GetCountNotificationsFailure({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}