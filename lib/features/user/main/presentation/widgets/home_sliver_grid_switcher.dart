import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/sliver_padding.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:sliver_tools/sliver_tools.dart';

class HomeSliverGridSwitcher extends StatefulWidget {
  final Widget gridView;
  final Widget listView;

  const HomeSliverGridSwitcher({
    super.key,
    required this.gridView,
    required this.listView,
  });

  @override
  State<HomeSliverGridSwitcher> createState() => _HomeSliverGridSwitcherState();
}

class _HomeSliverGridSwitcherState extends State<HomeSliverGridSwitcher> {
   bool isGrid = true;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => isGrid = !isGrid),
              child: AppImage.asset(
                Assets.icons.list,
                color: !isGrid
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurface,
              ),
            ),
            8.horizontalSpace,
            GestureDetector(
              onTap: () {
                setState(() => isGrid = !isGrid);
              },
              child: AppImage.asset(
                Assets.icons.grid,
                color: isGrid
                    ? context.colorScheme.primary
                    : context.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        20.verticalSpace.toSliver,
        SliverAnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: isGrid ? widget.gridView : widget.listView,
        ),
      ],
    );
  }
}
