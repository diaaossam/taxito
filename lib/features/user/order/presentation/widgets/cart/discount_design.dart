import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/api_config.dart';
import 'package:aslol/core/utils/app_constant.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:aslol/features/settings/settings_helper.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/custom_text_form_field.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscountDesign extends StatefulWidget {
  const DiscountDesign({super.key});

  @override
  State<DiscountDesign> createState() => _DiscountDesignState();
}

class _DiscountDesignState extends State<DiscountDesign> {
  String? code;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.screenWidth * .02,
          vertical: SizeConfig.bodyHeight * .02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              if (state is ApplyCouponToCartFailure) {
                AppConstant.showCustomSnakeBar(context, state.error, false);
              } else if (state is ApplyCouponToCartSuccess) {
                AppConstant.showCustomSnakeBar(
                    context, context.localizations.discountApplied, true);
              }
            },
            builder: (context, state) {
              return CustomTextFormField(
                controller: context.read<CartCubit>().discount,
                hintText: context.localizations.doYouHaveDiscountHint,
                prefixIcon: AppImage.asset(Assets.icons.ticket),
                filled: true,
                readOnly: context.read<CartCubit>().couponDiscount != 0,
                fillColor: context.colorScheme.background,
                suffixIcon: Padding(
                  padding: const EdgeInsetsDirectional.only(
                      end: 10, top: 4, bottom: 4),
                  child: context.read<CartCubit>().couponDiscount == 0
                      ? CustomButton(
                          textSize: 12,
                          radius: 10,
                          text: context.localizations.apply,
                          press: () {
                            if (ApiConfig.isGuest == true) {
                              SettingsHelper().showGuestDialog(context);
                              return;
                            }
                            if (context
                                .read<CartCubit>()
                                .discount
                                .text
                                .isNotEmpty) {
                              context.read<CartCubit>().appleCouponToCart(
                                  code:
                                      context.read<CartCubit>().discount.text);
                            }
                          },
                          width: SizeConfig.screenWidth * .22,
                        )
                      : InkWell(
                          onTap: () => context.read<CartCubit>().deleteCoupon(),
                          child: AppText(
                            text: context.localizations.cancel,
                            color: context.colorScheme.error,
                          )),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
