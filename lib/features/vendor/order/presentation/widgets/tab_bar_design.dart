import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabBarOrdersDesign extends StatelessWidget
    implements PreferredSizeWidget {
  final TabController tabController;
  final Function(int)? onTap;

  const TabBarOrdersDesign(
      {super.key, required this.tabController, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: Colors.transparent,
      onTap: onTap,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorSize: TabBarIndicatorSize.tab,
      unselectedLabelColor: context.colorScheme.onBackground,
      labelColor: context.colorScheme.onSurface,
      labelStyle: TextStyle(
          fontSize: 13.sp,
          fontFamily: AppStrings.arabicFont,
          fontWeight: FontWeight.w500),
      indicator: BoxDecoration(
        color: const Color(0xffE4EDE7),
        border: Border.all(color: context.colorScheme.tertiary, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      controller: tabController,
      tabs: [
        Tab(
          text: context.localizations.newWord,
        ),
        Tab(
          text: context.localizations.inPreparation,
        ),
        Tab(
          text: context.localizations.orderDonePrepare,
        ),
        Tab(
          text: context.localizations.withTheDelegate,
        ),
        Tab(
          text: context.localizations.delivered,
        ),
        Tab(
          text: context.localizations.canceled,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, SizeConfig.bodyHeight * .075);
}
