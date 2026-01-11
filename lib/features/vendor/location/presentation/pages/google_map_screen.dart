import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../cubit/location_cubit.dart';
import '../widget/location_map_widget.dart';

class GoogleMapScreen extends StatelessWidget {
  const GoogleMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LocationCubit>()..requestLocation(),
      child: const Scaffold(body: LocationMapBody()),
    );
  }
}
