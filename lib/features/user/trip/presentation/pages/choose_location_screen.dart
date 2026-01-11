import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../../../location/presentation/cubit/location_cubit.dart';
import '../widgets/choose_location/choose_location_body.dart';

class ChooseLocationScreen extends StatelessWidget {
  final bool isStart;

  const ChooseLocationScreen({super.key, required this.isStart});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LocationCubit>(),
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: ChooseLocationBody(
          isStart: isStart,
        ),
      ),
    );
  }
}
