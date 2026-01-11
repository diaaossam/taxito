import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/order/data/models/cart_model.dart';
import 'package:aslol/features/order/order_helper.dart';
import 'package:aslol/features/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:aslol/features/product/presentation/widgets/quantity_design.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class CartItemDesign extends StatelessWidget {
  final CartItem cartItem;
  final Function(CartItem) onDelete;

  const CartItemDesign(
      {super.key, required this.cartItem, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(16)),
          padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.screenWidth * .02,
              vertical: SizeConfig.bodyHeight * .02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AppImage.network(
                  height: SizeConfig.bodyHeight * .15,
                  width: SizeConfig.screenWidth * .25,
                  remoteImage: cartItem.productModel?.images?[0].url,
                  fit: BoxFit.cover,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    4.verticalSpace,
                    AppText(
                      text: cartItem.productModel?.title ?? "",
                      textSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                    8.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        AppText(
                          text:
                              "${formatPrice(price: cartItem.productModel?.price?.toString())} ${context.localizations.iqd}",
                          textSize: 14,
                        ),
                        6.horizontalSpace,
                        if(cartItem.productModel?.oldPrice != null)
                        AppText.hint(
                          text:
                              "${formatPrice(price: cartItem.productModel?.oldPrice?.toString())} ${context.localizations.iqd}",
                          textSize: 12,
                          textDecoration: TextDecoration.lineThrough,
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: AppImage.network(
                            width: SizeConfig.bodyHeight * .035,
                            height: SizeConfig.bodyHeight * .035,
                            fit: BoxFit.cover,
                            remoteImage: cartItem.productModel?.supplier?.logo,
                          ),
                        ),
                        7.horizontalSpace,
                        AppText(
                          text: cartItem.productModel?.supplier?.name ?? "",
                          textSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    8.verticalSpace,
                    QuantityDesign(
                      key: ValueKey("${cartItem.productModel?.id}"),
                      isCart: true,
                      isProductDetails: false,
                      buttonSize: 25,
                      count: cartItem.qty!.toInt(),
                      callback: (info) {
                        context.read<CartCubit>().setQuantity(
                            productId: cartItem.uniqueProductId ?? "",
                            isIncrease: info['isIncrease']);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
