import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/features/order/data/models/product_params.dart';
import 'package:aslol/features/search/presentation/pages/filter_screen.dart';
import 'package:flutter/material.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../widgets/image_picker/app_image.dart';

class FilterIcon extends StatelessWidget {
  final Function(ProductParams) paramsCallback;

  const FilterIcon({super.key, required this.paramsCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.navigateTo(
        const FilterScreen(),
        callback: (p0) {
          if (p0 != null && p0 is ProductParams) {
            paramsCallback(p0);
          }
        },
      ),
      child: Container(
        margin: const EdgeInsetsDirectional.only(end: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: const Color(0xffF7F7F7),
            border: Border.all(color: context.colorScheme.outline),
            shape: BoxShape.circle),
        child: AppImage.asset(
          Assets.icons.mageFilter,
        ),
      ),
    );
  }
}
