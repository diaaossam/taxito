import 'package:aslol/features/auth/presentation/cubit/update/update_bloc.dart';
import 'package:aslol/features/location/presentation/cubit/globale_location/global_location_cubit.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aslol/config/dependencies/injectable_dependencies.dart';
import 'package:aslol/features/auth/presentation/widgets/register/register_body.dart';

class RegisterScreen extends StatelessWidget {
  final String? phone;

  const RegisterScreen({super.key, this.phone});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UpdateBloc>(
          create: (context) => sl<UpdateBloc>(),
        ),
        BlocProvider<GlobalLocationCubit>(
          create: (context) => sl<GlobalLocationCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(),
        body: RegisterBody(
          phone: phone,
        ),
      ),
    );
  }
}
