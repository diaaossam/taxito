import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/user/presentation/bloc/profile/profile_bloc.dart';
import 'package:taxito/features/captain/user/presentation/bloc/profile/profile_state.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:taxito/widgets/rotate.dart';

import '../../../../../common/models/user_model.dart';

class UserProfileBodyDetails extends StatefulWidget {
  final UserModel userModel;
  final bool isMe;
  final Function(void) callback;

  const UserProfileBodyDetails(
      {super.key,
      required this.userModel,
      required this.isMe,
      required this.callback});

  @override
  State<UserProfileBodyDetails> createState() => _UserProfileBodyDetailsState();
}

class _UserProfileBodyDetailsState extends State<UserProfileBodyDetails> {
  UserModel? localeUserModel;

  @override
  void initState() {
    localeUserModel = widget.userModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
      if (state is GetUserDataSuccess) {
        setState(() {
          localeUserModel = state.userModel;
        });
      }
    }, builder: (context, state) {
      final bloc = context.read<ProfileBloc>();
      return RefreshIndicator(
        onRefresh: () async =>
            bloc.add(GetUserDataEvent(userId: widget.userModel.id)),
        child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    pinned: true,
                    title: AppText(
                      text: context.localizations.profile,
                      fontWeight: FontWeight.bold,
                      textSize: 20,
                    ),
                    leading: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Rotate(
                            child: AppImage.asset(
                          Assets.icons.arrowBack,
                          color: context.colorScheme.onSurface,
                        )),
                      ),
                    ),
                    actions: const [],
                  ),
                ],
            body: Padding(
              padding: screenPadding(),
              child: const CustomScrollView(
                slivers: [],
              ),
            )),
      );
    });
  }
}
