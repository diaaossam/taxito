import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/features/user/location/presentation/cubit/my_address/my_address_cubit.dart';
import 'package:taxito/features/user/order/data/models/cart_model.dart';
import 'package:taxito/features/user/order/data/models/payment_model.dart';
import 'package:taxito/features/user/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:taxito/features/user/order/presentation/pages/success_order_screen.dart';
import 'package:taxito/features/user/order/presentation/widgets/cart/discount_design.dart';
import 'package:taxito/features/user/order/presentation/widgets/payment_item_design.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/custom_divider_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../location/location_helper.dart';
import '../../../../location/presentation/widgets/location_info_widget.dart';
import '../../../../product/presentation/widgets/gift_widget.dart';
import '../cart/price_cart_design.dart';

class CheckOutBody extends StatefulWidget {
  const CheckOutBody({super.key});

  @override
  State<CheckOutBody> createState() => _CheckOutBodyState();
}

class _CheckOutBodyState extends State<CheckOutBody> {
  PaymentType? paymentMethod;
  num? shippingCost;

  @override
  void initState() {
    context.read<MyAddressCubit>().getLocationCost(
      supplierId:
          context.read<CartCubit>().cartList.first.productModel?.supplier?.id ??
          0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.bodyHeight * .02),
          GestureDetector(
            onTap: () => LocationHelper().showLocationDailog(
              context: context,
              myAddress: (p0) {},
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  text: context.localizations.address,
                  fontWeight: FontWeight.w600,
                ),
                10.verticalSpace,
                LocationInfoWidget(
                  onLocationSelected: (data) =>
                      setState(() => shippingCost = data),
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          const CustomDividerDesign(),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          AppText(
            text: context.localizations.paymentType,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final paymentModel = PaymentModel.allPayments(
                context: context,
                isCharge: true,
              )[index];
              return GestureDetector(
                onTap: () =>
                    setState(() => paymentMethod = paymentModel.paymentMethod),
                child: PaymentItemDesign(
                  isSelected: paymentMethod == paymentModel.paymentMethod,
                  paymentModel: paymentModel,
                ),
              );
            },
            separatorBuilder: (context, index) => 10.verticalSpace,
            itemCount: PaymentModel.allPayments(
              context: context,
              isCharge: true,
            ).length,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          const CustomDividerDesign(),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          const DiscountDesign(),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          const GiftWidget(),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          const CustomDividerDesign(),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          PriceCartDesign(shippingCost: shippingCost),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          BlocConsumer<CartCubit, CartState>(
            listener: (context, state) {
              if (state is PlaceOrderSuccess) {
                context.navigateTo(SuccessOrderScreen(id: state.orderId));
              } else if (state is PlaceOrderFailure) {
                AppConstant.showCustomSnakeBar(context, state.msg, false);
              }
            },
            builder: (context, state) {
              final bloc = context.read<CartCubit>();
              return CustomButton(
                isLoading: state is PlaceOrderLoading,
                text: context.localizations.doOrder,
                press: () {
                  if (paymentMethod == null) {
                    AppConstant.showCustomSnakeBar(
                      context,
                      context.localizations.paymentValidation,
                      false,
                    );
                    return;
                  }
                  CartModel cartModel = CartModel(
                    discountCode: bloc.couponDiscount != 0
                        ? bloc.discount.text
                        : null,
                    items: bloc.cartList,
                    paymentType: paymentMethod ?? PaymentType.cash,
                    addressId: ApiConfig.myAddress?.id,
                  );

                  bloc.placeOrder(cart: cartModel);
                },
              );
            },
          ),
        ],
      ).scrollable(),
    );
  }
}
