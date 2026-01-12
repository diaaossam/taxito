import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/features/user/search/presentation/cubit/filter/filter_cubit.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';
import 'category_filter_grid_design.dart';
import 'main_filter_grid_design.dart';

class FilterBody extends StatelessWidget {
  final bool isProduct;

  const FilterBody({super.key, required this.isProduct});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.bodyHeight * .02,
        horizontal: SizeConfig.screenWidth * .04,
      ),
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: context.localizations.categories,
            textSize: 14,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .01),
          const CategoryFilterGridDesign(),
          SizedBox(height: SizeConfig.bodyHeight * .04),
          if (isProduct) ...[
            AppText(
              text: context.localizations.viewBy,
              textSize: 14,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: SizeConfig.bodyHeight * .01),
            const MainFilterGridDesign(),
          ],

          SizedBox(height: SizeConfig.bodyHeight * .05),
          CustomButton(
            text: context.localizations.apply,
            press: () {
              final filterBloc = context.read<FilterCubit>();
              Navigator.pop(context, filterBloc.params);
            },
          ),
          SizedBox(height: SizeConfig.bodyHeight * .05),
        ],
      ).scrollable(),
    );
  }
}
