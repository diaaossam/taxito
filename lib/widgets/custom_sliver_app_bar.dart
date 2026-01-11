import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'app_text.dart';
import 'back_widget.dart';

class CustomSliverAppBar extends StatelessWidget {
  final VoidCallback? pressIcon;
  final String? title;
  final List<Widget>? actions;
  final Widget? titleWidget;
  final bool? isCenterTitle;
  final bool? pinned;
  final PreferredSizeWidget? preferredSizeWidget;
  final bool showLeading;
  final Widget? flexibleSpace;
  final double? expandedHeight;

  const CustomSliverAppBar({
    super.key,
    this.pressIcon,
    this.title,
    this.actions,
    this.titleWidget,
    this.expandedHeight,
    this.preferredSizeWidget,
    this.flexibleSpace,
    this.isCenterTitle = true,
    this.showLeading = true,
    this.pinned = true, // عشان الاب بار يفضل ثابت فوق لو عاوز
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: pinned ?? true,
      automaticallyImplyLeading: false,
      leadingWidth: SizeConfig.screenWidth * .2,
      centerTitle: isCenterTitle,
      elevation: 1,
      forceElevated: true,
      title: titleWidget ??
          AppText(
            text: title != null ? title.toString() : "",
            fontWeight: FontWeight.w600,
            textSize: 14,
          ),
      bottom: preferredSizeWidget,
      leading: showLeading
          ? BackArrowWidget(
              margin: const EdgeInsetsDirectional.all(7),
              callback: pressIcon ?? () => Navigator.pop(context),
            )
          : null,
      actions: actions,
      flexibleSpace: flexibleSpace,
      expandedHeight: expandedHeight,
    );
  }
}
