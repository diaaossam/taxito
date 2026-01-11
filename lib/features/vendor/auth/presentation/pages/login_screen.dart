import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependencies/injectable_dependencies.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/login/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return const Scaffold(
            appBar: CustomAuthAppBar(
              showBack: false,
            ),
            body: LoginBodyWidget(),
          );
        },
      ),
    );
  }
}
