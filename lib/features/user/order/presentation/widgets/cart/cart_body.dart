import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/sliver_padding.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/settings/settings_helper.dart';
import 'package:taxito/features/user/order/order_helper.dart';
import 'package:taxito/features/user/order/presentation/widgets/cart/cart_item_design.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../supplier/presentation/widgets/supplier_product_list.dart';
import '../../bloc/cart/cart_cubit.dart';
import '../../pages/check_out_screen.dart';
import 'empty_cart_design.dart';

class CartBody extends StatefulWidget {
  const CartBody({super.key});

  @override
  State<CartBody> createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {
  PaymentType? paymentType;
  TextEditingController note = TextEditingController();

  @override
  void initState() {
    context.read<CartCubit>().getCartData(isRemote: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state is PlaceOrderFailure) {
          AppConstant.showCustomSnakeBar(context, state.msg, false);
        } else if (state is PlaceOrderSuccess) {
          context.read<CartCubit>().getCartData(isRemote: false);
          OrderHelper().showSuccessOrderDialog(context: context, id: state.orderId);
        }
      },
      builder: (context, state) {
        final bloc = context.read<CartCubit>();
        if (state is GetCartListLoading) {
          return const LoadingWidget();
        }
        if (bloc.cartList.isEmpty) {
          return const EmptyCartDesign();
        }
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildBuilderDelegate(
                childCount: bloc.cartList.length,
                (context, index) => Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: CartItemDesign(
                    onDelete: (p0) => bloc.deleteItemFromCart(
                      id: p0.uniqueProductId.toString(),
                    ),
                    cartItem: bloc.cartList[index],
                  ),
                ),
              )),
              30.verticalSpace.toSliver,
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () {
                      if(ApiConfig.isGuest == true){
                        SettingsHelper().showGuestDialog(context);
                        return;
                      }
                      context.navigateTo(const CheckOutScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.bodyHeight * .01, horizontal: 10),
                      decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                color: Color(0xffFCD392),
                                shape: BoxShape.circle,
                              ),
                              child: AppText(
                                text: context
                                    .read<CartCubit>()
                                    .totalCount
                                    .toString(),
                                fontWeight: FontWeight.w600,
                                textSize: 14,
                                color: Colors.white,
                              ),
                            ),
                            10.horizontalSpace,
                            AppText(
                              text: "${context.localizations.goToCheckOut} ",
                              fontWeight: FontWeight.w600,
                              textSize: 14,
                              color: Colors.white,
                            ),
                            const Spacer(),
                            AppText(
                              text:
                                  "${formatPrice(price: bloc.amount.toInt().toString())} ${context.localizations.iqd} ",
                              fontWeight: FontWeight.w600,
                              textSize: 14,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              40.verticalSpace.toSliver,
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                sliver: SliverToBoxAdapter(
                  child: AppText(text: "${context.localizations.suggestedNote}${ bloc.cartList.first.productModel?.supplier?.name}",fontWeight: FontWeight.w600,),
                ),
              ),
              10.verticalSpace.toSliver,
              SupplierProductList(supplierId: bloc.cartList.first.productModel?.supplier?.id??0,),
              40.verticalSpace.toSliver,
            ],
          ),
        );
      },
    );
  }
}
