import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../main/presentation/cubit/delivery_main/delivery_main_cubit.dart';
import '../cubit/categories_cubit.dart';
import '../widgets/categories/category_body.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<DeliveryMainCubit>().changeBottomNavIndex(index: 0);
      },
      child: BlocProvider(
        create: (context) => sl<CategoriesCubit>(),
        child: Scaffold(
          appBar: CustomAppBar(
            showBackButton: false,
            title: context.localizations.categories,
          ),
          body: const CategoryBody(),
        ),
      ),
    );
  }
}
