import 'package:flutter/material.dart';

import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/back_widget.dart';

class CustomAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? pressIcon;
  final String? title;
  final double elevation;
  final Color? color;
  final List<Widget>? actions;
  final bool? isWithBackText;
  final bool? showBack;

  const CustomAuthAppBar({
    super.key,
    this.pressIcon,
    this.showBack = false,
    this.title,
    this.actions,
    this.elevation = 0,
    this.color,
    this.isWithBackText,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: AppText(
        text: title ?? "",
        fontWeight: FontWeight.bold,
        textSize: 22,
      ),
      elevation: elevation,
      shadowColor: color,
      actions: actions,
      leadingWidth: SizeConfig.screenWidth * .3,
      leading: showBack == true
          ? BackArrowWidget(
              callback: pressIcon ??
                  () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
              padding: const EdgeInsets.all(10))
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight - 20);
}
