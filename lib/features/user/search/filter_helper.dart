import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/user/search/presentation/pages/filter_screen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class FilterHelper {
  List<DropdownMenuItem<String>> priceList(BuildContext context) {
    final List<String> priceList = [];
    for (int i = 100000; i < 10000000; i = i + 100000) {
      priceList.add(i.toString());
    }
    return priceList
        .map((e) => DropdownMenuItem<String>(
              value: e,
              child: Row(
                children: [
                  AppText(text: e),
                  5.horizontalSpace,
                  AppText(
                    text: context.localizations.iqd,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            ))
        .toList();
  }

  Future<dynamic> showFilterDailog({required BuildContext context}) async {
    final response = await showCupertinoModalBottomSheet(
      context: context,
      bounce: true,
      builder: (context) => const FilterScreen(),
    );
    return response;
  }
}
