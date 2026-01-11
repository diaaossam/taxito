import 'package:flutter/material.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  final bool isWithScaffold;
  final double? size;

  const LoadingWidget(
      {super.key, this.color, this.isWithScaffold = false, this.size});

  @override
  Widget build(BuildContext context) {
    if (isWithScaffold) {
      return Scaffold(
        body: Center(
          child: LoadingAnimationWidget.threeArchedCircle(
            size: size ?? SizeConfig.bodyHeight * 0.06,
            color: color ?? context.colorScheme.primary,
          ),
        ),
      );
    } else {
      return Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          size: size ?? SizeConfig.bodyHeight * 0.06,
          color: color ?? context.colorScheme.primary,
        ),
      );
    }
  }
}
