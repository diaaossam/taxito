import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/order/data/models/cart_model.dart';
import 'package:taxito/features/user/order/order_helper.dart';
import 'package:taxito/core/data/models/product_model.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../cubit/product_details/product_details_cubit.dart';

class ProductInfoCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductInfoCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
      builder: (context, state) {
        final bloc = context.read<ProductDetailsCubit>();
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: SizeConfig.bodyHeight * .02),
          decoration: BoxDecoration(color: context.colorScheme.surface),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: productModel.title ?? "",
                textSize: 15,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
              Row(
                children: [
                  AppText(
                    textSize: 16,
                    text:
                        "${formatPrice(price: context.read<ProductDetailsCubit>().cartItem.productModel?.price?.toString())} ${context.localizations.iqd}",
                    fontWeight: FontWeight.w500,
                  ),
                  if (productModel.oldPrice != null &&
                      productModel.oldPrice != 0) ...{
                    8.horizontalSpace,
                    AppText(
                      textDecoration: TextDecoration.lineThrough,
                      text:
                          "${formatPrice(price: productModel.oldPrice?.toString())} ${context.localizations.iqd}",
                    ),
                  }
                ],
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
              AppText.hint(
                text: productModel.description ?? "",
                textSize: 14,
                maxLines: 4,
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .015,
              ),
            ],
          ),
        );
      },
    );
  }
}
