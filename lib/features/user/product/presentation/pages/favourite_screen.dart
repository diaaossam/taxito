import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/features/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependencies/injectable_dependencies.dart';
import '../widgets/favourite/favourite_body.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavouriteCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(title: context.localizations.favourites,),
        body: const FavouriteBody(),
      ),
    );
  }
}
