import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/api_config.dart';
import 'package:aslol/features/order/order_helper.dart';
import 'package:aslol/features/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';


class PriceCartDesign extends StatelessWidget {
  final num ? shippingCost;
  const PriceCartDesign({super.key,  this.shippingCost});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final bloc = context.read<CartCubit>();
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
              AppText(
                text: context.localizations.invoice,
                fontWeight: FontWeight.w600,
              ),
              20.verticalSpace,
              Padding(
                padding: screenPadding(),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text: context.localizations.total,
                          ),
                        ),
                        AppText(
                          text:
                          "${formatPrice(price: bloc.amount.toString())} ${context.localizations.iqd}",
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                    15.verticalSpace,
                    if (shippingCost != null) ...{
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              text: context.localizations.shippingCost,
                            ),
                          ),
                          AppText(
                            text: "${formatPrice(price: shippingCost.toString())} ${context.localizations.iqd}",
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      15.verticalSpace,
                    },
                    if (bloc.couponDiscount != 0) ...{
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              color: context.colorScheme.error,
                              text: context.localizations.discount,
                            ),
                          ),
                          AppText(
                            color: context.colorScheme.error,
                            text:
                            " - ${formatPrice(price: bloc.couponDiscount.toString())} ${context.localizations.iqd}",
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      15.verticalSpace,
                    },
                    if (bloc.pointDiscount != 0) ...{
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              color: context.colorScheme.error,
                              text: context.localizations.discount,
                            ),
                          ),
                          AppText(
                            color: context.colorScheme.error,
                            text:
                            " - ${formatPrice(price: bloc.pointDiscount.toString())} ${context.localizations.iqd}",
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      15.verticalSpace,
                    },
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            text: context.localizations.totalPrice,
                            fontWeight: FontWeight.w700,
                            textSize: 15,
                            color: context.colorScheme.tertiary,
                          ),
                        ),
                        AppText(
                          text: _setUpPrice(
                              amount: bloc.amount,
                              context: context,
                              couponDiscount: bloc.couponDiscount,
                              pointDiscount: bloc.pointDiscount,
                              deleivery: (shippingCost ??
                                  0)),
                          fontWeight: FontWeight.w700,
                          textSize: 15,
                          color: context.colorScheme.tertiary,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _setUpPrice(
      {required num amount,
        required num deleivery,
        required BuildContext context,
        required num couponDiscount,
        required num pointDiscount,
        }) {
    return "${formatPrice(price: (amount + deleivery - couponDiscount - pointDiscount).toString())} ${context.localizations.iqd}";
  }
}