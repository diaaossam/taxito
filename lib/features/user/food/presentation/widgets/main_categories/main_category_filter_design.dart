import 'package:aslol/config/theme/theme_helper.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/main/data/models/banners_model.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_size.dart';

class MainCategoryFilterItem extends StatelessWidget {
  final BannersModel bannersModel;
  final bool isSelected;

  const MainCategoryFilterItem(
      {super.key, required this.bannersModel, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * .03, vertical: 10),
      decoration: BoxDecoration(
          color: isSelected
              ? context.colorScheme.onPrimary
              : const Color(0xffF8F8F8),
          border: Border.all(
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.outline),
          borderRadius: BorderRadius.circular(14)),
      child: Row(
        mainAxisSize: MainAxisSize.min, // ✅ ده مهم جداً
        children: [
          8.horizontalSpace,
          AppImage.network(
            height: SizeConfig.screenWidth * .04,
            remoteImage: bannersModel.image ?? "",
          ),
          10.horizontalSpace,
          AppText(
            text: bannersModel.title ?? "",
            maxLines: 2,
            textSize: 11,
            align: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Text formatTitleRich(String title, BuildContext context) {
    List<String> words = title.trim().split(RegExp(r'\s+'));

    if (words.length == 1) {
      return Text.rich(
        style: ThemeHelper().customCategoryTextStyle(context: context),
        TextSpan(
          text: words[0],
          style: ThemeHelper().customCategoryTextStyle(context: context),
        ),
      );
    } else if (words.length == 2) {
      return Text.rich(
        style: ThemeHelper().customCategoryTextStyle(context: context),
        TextSpan(
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.tertiary,
          ),
          children: [
            TextSpan(text: '${words[0]}\n'),
            TextSpan(text: words[1]),
          ],
        ),
      );
    } else if (words.length >= 3) {
      return Text.rich(
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w600,
          color: context.colorScheme.tertiary,
        ),
        TextSpan(
          style: ThemeHelper().customCategoryTextStyle(context: context),
          children: [
            TextSpan(text: '${words[0]}\n'),
            TextSpan(text: '${words[1]} '),
            TextSpan(text: words[2]),
          ],
        ),
      );
    } else {
      return const Text("");
    }
  }
}
