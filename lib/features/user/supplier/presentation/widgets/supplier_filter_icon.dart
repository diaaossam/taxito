import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/user/order/data/models/product_params.dart';
import 'package:taxito/features/user/search/presentation/pages/filter_screen.dart';
import 'package:taxito/features/user/supplier/data/models/requests/suppliers_params.dart';
import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/image_picker/app_image.dart';

class SupplierFilterIcon extends StatelessWidget {
  final Function(SuppliersParams) paramsCallback;

  const SupplierFilterIcon({super.key, required this.paramsCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.navigateTo(
        const FilterScreen(isProduct: false),
        callback: (p0) {
          if (p0 != null) {
            paramsCallback(
              SuppliersParams(
                pageKey: 1,
                supplierCategories: (p0 as ProductParams).supplierCategories,
              ),
            );
          }
        },
      ),
      child: Container(
        margin: const EdgeInsetsDirectional.only(end: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: const Color(0xffF7F7F7),
          border: Border.all(color: context.colorScheme.outline),
          shape: BoxShape.circle,
        ),
        child: AppImage.asset(Assets.icons.mageFilter),
      ),
    );
  }
}
