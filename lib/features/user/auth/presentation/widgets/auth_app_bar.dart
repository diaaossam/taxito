import 'package:flutter/material.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/back_widget.dart';

class CustomAuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? pressIcon;
  final String? title;
  final double elevation;
  final Color? color;
  final List<Widget>? actions;

  const CustomAuthAppBar({
    super.key,
    this.pressIcon,
    this.title,
    this.actions,
    this.elevation = 0,
    this.color,
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
      leadingWidth: SizeConfig.screenWidth * .2,
      leading: BackArrowWidget(
          callback: pressIcon ??
              () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
          padding: const EdgeInsets.all(10)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
