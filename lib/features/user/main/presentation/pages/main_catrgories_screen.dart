import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/features/food/presentation/widgets/main_categories/main_categories_body.dart';
import 'package:aslol/features/main/presentation/cubit/banner/banners_cubit.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependencies/injectable_dependencies.dart';

class MainCatergoriesScreen extends StatelessWidget {
  const MainCatergoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BannersCubit>(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.localizations.categories,
          showBackButton: true,
        ),
        body: const MainCategoriesBody(),
      ),
    );
  }
}
