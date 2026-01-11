import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/start/presentation/cubit/boarding/on_boarding_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProgressCirculureWidget extends StatefulWidget {
  const ProgressCirculureWidget({super.key});

  @override
  State<ProgressCirculureWidget> createState() =>
      _ProgressCirculureWidgetState();
}

class _ProgressCirculureWidgetState extends State<ProgressCirculureWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
      builder: (context, state) {
        final bloc = context.read<OnBoardingCubit>();

        final progress =
            (bloc.boardController.page ?? 0) / (bloc.introList.length - 1);
        return SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.primary),
            backgroundColor: context.colorScheme.primary.withOpacity(0.2),
          ),
        );
      },
    );
  }
}
