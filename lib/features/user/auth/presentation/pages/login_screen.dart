import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aslol/config/dependencies/injectable_dependencies.dart';
import 'package:aslol/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:aslol/features/auth/presentation/widgets/login/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: const Scaffold(
        body: LoginBodyWidget(),
      ),
    );
  }
}
