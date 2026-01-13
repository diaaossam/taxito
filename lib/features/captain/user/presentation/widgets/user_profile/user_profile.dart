import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/features/captain/user/presentation/bloc/profile/profile_bloc.dart';
import 'package:taxito/features/captain/user/presentation/bloc/profile/profile_state.dart';
import 'package:taxito/features/captain/user/presentation/widgets/user_profile/user_profile_body_details.dart';
import 'package:taxito/widgets/app_failure.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';

import '../../../../../common/models/user_model.dart';
import '../../../../../common/models/user_model_helper.dart';

class UserProfileBody extends StatefulWidget {
  final UserModel? userModel;
  final bool isReload;

  const UserProfileBody({super.key, this.userModel, required this.isReload});

  @override
  State<UserProfileBody> createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = widget.userModel ?? UserDataService().getUserData();
    bool isMe = user?.id == UserDataService().getUserData()?.id;
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProfileInitial && widget.isReload ||
            state is GetUserDataLoading && widget.isReload) {
          return const LoadingWidget();
        }
        if (state is GetUserDataFailure) {
          return const AppFailureWidget();
        }
        if (state is GetUserDataSuccess && widget.isReload) {
          user = state.userModel;
          return UserProfileBodyDetails(
            callback: (p0) => setState(() {}),
            userModel: user!,
            isMe: isMe,
          );
        }
        return UserProfileBodyDetails(
          callback: (p0) => setState(() {}),
          userModel: user!,
          isMe: isMe,
        );
      },
    );
  }
}
