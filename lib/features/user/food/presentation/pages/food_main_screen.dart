import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/user/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../widgets/food_main/food_main_body.dart';

class FoodMainScreen extends StatelessWidget {
  const FoodMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<FavouriteCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.localizations.foodRequest,
        ),
        body: const FoodMainBody(),
      ),
    );
  }
}
