import 'package:taxito/core/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/features/captain/user/presentation/bloc/profile/profile_bloc.dart';
import 'package:taxito/features/captain/user/presentation/bloc/profile/profile_state.dart';
import 'package:taxito/features/captain/user/presentation/widgets/user_profile/user_profile.dart';

class UserProfileScreen extends StatelessWidget {
  final UserModel? userModel;
  final bool isReload;

  const UserProfileScreen({
    super.key,
    this.userModel,
    this.isReload = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (userModel == null) {
          return sl<ProfileBloc>();
        } else {
          return sl<ProfileBloc>()
            ..add(GetUserDataEvent(userId: userModel?.id ?? 0));
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return Scaffold(
            body: UserProfileBody(
              isReload: isReload,
              userModel: userModel,
            ),
          );
        },
      ),
    );
  }
}
