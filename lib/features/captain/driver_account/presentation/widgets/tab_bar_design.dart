import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_size.dart';
import '../../../../../core/utils/app_strings.dart';

class TabBarDesign extends StatelessWidget implements PreferredSizeWidget {
  final TabController tabController;

  const TabBarDesign({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: screenPadding(),
      child: ColoredTabBar(
        color: Colors.transparent,
        tabBar: TabBar(
          dividerColor: Colors.transparent,
          indicatorSize: TabBarIndicatorSize.tab,
          unselectedLabelColor: context.colorScheme.onBackground,
          labelColor: context.colorScheme.primary,
          labelStyle: const TextStyle(
              fontSize: 12,
              fontFamily: AppStrings.arabicFont,
              fontWeight: FontWeight.bold),
          controller: tabController,
          tabs: [
            Tab(
              text: context.localizations.personalInfo,
            ),
            Tab(
              text: context.localizations.licenseData,

            ),
            Tab(
              text: context.localizations.vehicleInfo,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, SizeConfig.bodyHeight * .075);
}

class ColoredTabBar extends ColoredBox implements PreferredSizeWidget {
  const ColoredTabBar({super.key, required this.color, required this.tabBar})
      : super(color: color, child: tabBar);

  @override
  final Color color;
  final TabBar tabBar;

  @override
  Size get preferredSize => tabBar.preferredSize;
}
