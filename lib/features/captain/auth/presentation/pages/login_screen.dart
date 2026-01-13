import 'package:taxito/core/enum/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/login/login_body.dart';

class LoginScreen extends StatelessWidget {
  final UserType userType;

  const LoginScreen({super.key, required this.userType});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: Scaffold(
        appBar: const CustomAuthAppBar(
          showBack: false,
        ),
        body: LoginBodyWidget(
          userType: userType,
        ),
      ),
    );
  }
}
