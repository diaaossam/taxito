import 'package:flutter/material.dart';
import 'package:taxito/core/utils/app_size.dart';

extension CustomScrollViewExtension on CustomScrollView {
  CustomScrollView withSpacing({double? spacing}) {
    final List<Widget> spacedSlivers = [];
    for (int i = 0; i < slivers.length; i++) {
      spacedSlivers.add(slivers[i]);
      if (i < slivers.length - 1) {
        spacedSlivers.add(SliverToBoxAdapter(
          child: SizedBox(
            height: spacing ?? SizeConfig.bodyHeight * .02,
          ),
        ));
      }
    }

    return CustomScrollView(
      physics: physics,
      slivers: spacedSlivers,
    );
  }
}

extension SliverSizedBox on SizedBox {
  Widget get toSliver => SliverToBoxAdapter(child: this);
}

extension SliverPaddingExtension on Widget {
  Widget toSliverPadding({EdgeInsets? padding}) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .04),
      sliver: SliverToBoxAdapter(child: this),
    );
  }
}
