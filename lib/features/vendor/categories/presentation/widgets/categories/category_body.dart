import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/categories_cubit.dart';
import '../../pages/add_edit_category_screen.dart';
import '../categories_grid.dart';

class CategoryBody extends StatelessWidget {
  const CategoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        children: [
          SizedBox(height: SizeConfig.bodyHeight * .02),
          CustomButton(
            text: context.localizations.addNewCategory,
            press: () {
              context.navigateTo(
                const AddEditCategoryScreen(),
                callback: (p0) {
                  if (p0) {
                    context.read<CategoriesCubit>().pagingController.refresh();
                  }
                },
              );
            },
            backgroundColor: Colors.transparent,
            textColor: context.colorScheme.primary,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          const Expanded(child: CategoriesGrid()),
        ],
      ),
    );
  }
}
