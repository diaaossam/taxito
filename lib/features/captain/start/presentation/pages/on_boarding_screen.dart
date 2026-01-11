import 'package:taxito/features/captain/start/presentation/cubit/boarding/on_boarding_cubit.dart';
import 'package:taxito/features/captain/start/presentation/widgets/on_boarding/boarding_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OnBoardingCubit>()..getIntroData(),
      child: const Scaffold(
        body: Body(),
      ),
    );
  }
}
