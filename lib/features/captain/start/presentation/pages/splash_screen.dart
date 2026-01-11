import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/start/presentation/cubit/start/start_cubit.dart';
import 'package:taxito/features/captain/start/presentation/widgets/splash_screen/splash_screen_body.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocProvider(
      create: (context) => sl<StartCubit>(),
      child: Scaffold(
        backgroundColor: context.colorScheme.primary,
        body: const SplashScreenBody(),
      ),
    );
  }
}
