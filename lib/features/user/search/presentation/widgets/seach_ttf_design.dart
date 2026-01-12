import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/search/filter_helper.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../pages/search_screen.dart';

class SearchTextFormFieldDesign extends StatelessWidget {
  const SearchTextFormFieldDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Row(
        children: [
          Expanded(
              child: CustomTextFormField(
            hintText: context.localizations.searchHint,
            readOnly: true,
            onTap: () => context.navigateTo(const SearchScreen()),
            prefixIcon: AppImage.asset(Assets.icons.searchNormal),
          )),
          10.horizontalSpace,
          InkWell(
            onTap: () async {
              final response =
                  await await FilterHelper().showFilterDailog(context: context);
              context.navigateTo(SearchScreen(
                params: response,
              ));
            },
            child: Container(
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border:
                      Border.all(color: context.colorScheme.outline, width: 1),
                ),
                child: AppImage.asset(Assets.icons.mageFilter)),
          )
        ],
      ),
    );
  }
}
