import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/dependencies/injectable_dependencies.dart';
import '../cubit/add_new_address/add_new_address_cubit.dart';
import '../cubit/globale_location/global_location_cubit.dart';
import '../widgets/auth_location_body/auth_location_body.dart';

class AuthLocationScreen extends StatelessWidget {
  const AuthLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AddNewAddressCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GlobalLocationCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.localizations.locationPicker,
        ),
        body: const AuthLocationBody(),
      ),
    );
  }
}
