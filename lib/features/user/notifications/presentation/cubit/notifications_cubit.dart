import 'package:taxito/features/user/notifications/domain/usecases/get_notification_count_use_case.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/features/user/notifications/data/models/notification_model.dart';
import 'package:taxito/features/user/notifications/domain/usecases/get_notification_list_use_case.dart';
import 'package:taxito/features/user/notifications/domain/usecases/mark_all_as_read_use_case.dart';

part 'notifications_state.dart';

@Injectable()
class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationListUseCase _getNotificationListUseCase;
  final MarkAllAsReadUseCase markAllAsReadUseCase;
  final GetNotificationsCount getNotificationsCount;

  NotificationsCubit(this._getNotificationListUseCase,
      this.markAllAsReadUseCase, this.getNotificationsCount)
      : super(NotificationsInitial());

  final PagingController<int, NotificationModel> pagingController =
      PagingController(firstPageKey: 1);

  static NotificationsCubit get(context) => BlocProvider.of(context);

  Future<void> getNotificationCount() async {
    emit(GetCountNotificationsLoading());
    final response = await getNotificationsCount();
    emit(response.fold(
      (l) => GetCountNotificationsFailure(errorMsg: l.msg),
      (r) => GetCountNotificationsSuccess(count: r.data),
    ));
  }

  Future<void> getAllNotifications({required int pageKey}) async {
    if (pageKey == 1) {
      markAllAsRead();
    }
    List<NotificationModel> notifications = [];
    final response = await _getNotificationListUseCase(pageKey: pageKey);
    response.fold(
      (l) {
        notifications = [];
      },
      (r) {
        notifications = r;
      },
    );

    try {
      final isLastPage = notifications.length < 10;
      if (isLastPage) {
        pagingController.appendLastPage(notifications);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(notifications, nextPageKey.toInt());
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  Future<void> markAllAsRead() async {
    emit(MarkAllNotificationAsReadLoading());
    final response = await markAllAsReadUseCase();
    emit(response.fold((l) => MarkAllNotificationAsReadFailure(errorMsg: l.msg),
        (r) => MarkAllNotificationAsReadSuccess()));
  }
}
