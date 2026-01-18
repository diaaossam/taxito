import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/utils/app_size.dart';
import 'app_text.dart';
import 'back_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? pressIcon;
  final String? title;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final Widget? leadingWidget;
  final double? leadingWidth;
  final bool? isCenterTitle;
  final bool showBackButton;
  final double? elevation;

  const CustomAppBar(
      {super.key,
      this.pressIcon,
      this.title,
      this.leadingWidth,
      this.elevation,
      this.leadingWidget,
      this.actions,
      this.showBackButton = true,
      this.titleWidget,
      this.isCenterTitle = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: leadingWidth ?? SizeConfig.screenWidth * .13,
      elevation: 0,
      centerTitle: isCenterTitle,
      title: titleWidget ??
          AppText(
            text: title != null ? title.toString() : "",
            fontWeight: FontWeight.w600,
            textSize: 14,
          ),
      leading: leadingWidget ??
          Visibility(
            visible: showBackButton,
            child: BackArrowWidget(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsetsDirectional.only(start: 10),
              callback: pressIcon ?? () =>Navigator.canPop(context)? Navigator.pop(context): null,
            ),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
