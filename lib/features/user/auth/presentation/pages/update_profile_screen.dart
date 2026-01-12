import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/user/auth/presentation/cubit/update/update_bloc.dart';
import 'package:taxito/features/user/location/presentation/cubit/globale_location/global_location_cubit.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../widgets/update_screen/update_body.dart';

class UpdateProfileScreen extends StatelessWidget {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<UpdateBloc>()),
        BlocProvider(create: (context) => sl<GlobalLocationCubit>()),
      ],
      child: Scaffold(
        appBar: CustomAppBar(title: context.localizations.editProfileInfo),
        body: const UpdateBody(),
      ),
    );
  }
}
