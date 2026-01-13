import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../common/models/trip_model.dart';
import '../../../../../../core/utils/app_strings.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/custom_app_bar.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../data/models/message_model.dart';
import '../../bloc/message/message_bloc.dart';
import 'message_bottom_nav.dart';
import 'text/message_bubble_design.dart';

class MessageBody extends StatefulWidget {
  final TripModel tripModel;

  const MessageBody({super.key, required this.tripModel});

  @override
  State<MessageBody> createState() => _MessageBodyState();
}

class _MessageBodyState extends State<MessageBody> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<MessageBloc>();
    bloc.pagingController.addPageRequestListener((pageKey) {
      bloc.fetchPage(pageKey: pageKey, tripModel: widget.tripModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSupportChat = widget.tripModel.id == null;
    return BlocConsumer<MessageBloc, MessageState>(
      listener: (context, state) {},
      builder: (context, state) {
        final bloc = context.read<MessageBloc>();
        return Scaffold(
          appBar: CustomAppBar(
            elevation: 1,
            title: isSupportChat
                ? context.localizations.technicalSupport
                : context.localizations.contactDriver,
            pressIcon: () {
              final shared = sl<SharedPreferences>();
              shared.remove(AppStrings.notifications);
              Navigator.pop(context);
            },
            //title: widget.chatsModel.user?.publicName,
          ),
          body: CustomScrollView(
            reverse: true,
            slivers: [
              PagedSliverList<int, MessageModel>(
                pagingController: bloc.pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, item, index) => MessageBubbleDesign(
                    key: ValueKey(item.id),
                    messageModel: item,
                    tripModel: widget.tripModel,
                  ),
                  noItemsFoundIndicatorBuilder: (context) =>
                      _buildNoChatFound(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: MessageBottomNav(tripModel: widget.tripModel),
        );
      },
    );
  }

  Widget _buildNoChatFound() {
    return Opacity(
      opacity: 0.2,
      child: Padding(
        padding: const EdgeInsets.all(120.0),
        child: AppImage.asset(
          color: context.colorScheme.primary,
          Assets.icons.messageText,
        ),
      ),
    );
  }
}
