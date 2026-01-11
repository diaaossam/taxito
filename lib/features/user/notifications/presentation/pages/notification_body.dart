import 'package:aslol/features/notifications/data/models/notification_model.dart';
import 'package:aslol/features/notifications/presentation/widgets/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_failure.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationBody extends StatefulWidget {
  const NotificationBody({super.key});

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  @override
  void initState() {
    final bloc = context.read<NotificationsCubit>();
    bloc.pagingController.addPageRequestListener(
      (pageKey) {
        bloc.getAllNotifications(pageKey: pageKey);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final bloc = context.read<NotificationsCubit>();
        return CustomScrollView(
          slivers: [
            PagedSliverList(
                pagingController: bloc.pagingController,
                builderDelegate: PagedChildBuilderDelegate<NotificationModel>(
                    firstPageErrorIndicatorBuilder: (context) => CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: AppFailureWidget(
                                callback: () => context
                                    .read<NotificationsCubit>()
                                    .pagingController
                                    .refresh(),
                                image: Assets.images.logo.path,
                                buttonText: context.localizations.tryAgain,
                                title: context.localizations.noDataHere,
                              ),
                            )
                          ],
                        ),
                    noItemsFoundIndicatorBuilder: (context) => AppFailureWidget(
                      image: Assets.images.noNotifications.path,
                      title: context.localizations.sorryNoNotifications1,
                      body: context.localizations.sorryNoNotifications2,
                      buttonText: context.localizations.backHome,
                      callback: () => Navigator.pop(context),
                    ),
                    itemBuilder: (context, item, index) => NotificationItem(model: item))),
          ],
        );
      },
    );
  }
}
