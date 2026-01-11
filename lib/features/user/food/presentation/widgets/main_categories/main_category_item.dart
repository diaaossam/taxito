import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/features/main/data/models/banners_model.dart';
import 'package:aslol/features/order/data/models/product_params.dart';
import 'package:aslol/features/product/presentation/pages/all_products_screen.dart';
import 'package:aslol/features/supplier/presentation/pages/all_suppliers_screen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_size.dart';

class MainCategoryItem extends StatelessWidget {
  final double? imageHeight;
  final double? textSize;
  final bool isHome;
  final BannersModel bannersModel;

  const MainCategoryItem(
      {super.key,
      required this.bannersModel,
      this.imageHeight,
      this.textSize,
      this.isHome = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.navigateTo(AllSuppliersScreen(
        model: bannersModel,
      )),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: AppImage.network(
                height: imageHeight ?? SizeConfig.bodyHeight * .05,
                remoteImage: bannersModel.image ?? "",
                fit: BoxFit.contain,
              ),
            ),
          ),
          Padding(
              padding: EdgeInsetsDirectional.only(
                  top: SizeConfig.bodyHeight * .01,
                  start: SizeConfig.screenWidth * .02),
              child: AppText(
                align: TextAlign.center,
                text: splitTitle(bannersModel.title ?? ""),
                textSize: textSize ?? 12,
                fontWeight: FontWeight.w400,
              ))
        ],
      ),
    );
  }

  String splitTitle(String title) {
    List<String> parts = title.split(" ");
    if (parts.length > 1) {
      return "${parts.sublist(0, parts.length - 1).join(" ")}\n${parts.last}";
    }
    return title;
  }
}
