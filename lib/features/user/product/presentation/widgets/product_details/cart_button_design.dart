import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:taxito/features/user/order/data/models/cart_model.dart';
import 'package:taxito/features/user/order/order_helper.dart';
import 'package:taxito/features/user/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:taxito/features/common/models/product_model.dart';
import 'package:taxito/features/user/product/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:taxito/features/user/product/presentation/widgets/quantity_design.dart';
import 'package:taxito/features/user/product/product_helper.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartButtonDesign extends StatefulWidget {
  final ProductModel productModel;

  const CartButtonDesign({super.key, required this.productModel});

  @override
  State<CartButtonDesign> createState() => _CartButtonDesignState();
}

class _CartButtonDesignState extends State<CartButtonDesign> {
  bool isExists = false;

  @override
  void initState() {
    context.read<CartCubit>().getCartData(isRemote: false);
    initProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartCubit, CartState>(
      listener: (context, state) {
        if (state is AddCartListStateSuccess) {
          setState(() => isExists = true);
        }
      },
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            final bloc = context.read<ProductDetailsCubit>();
            if (isExists) {
              return InkWell(
                onTap: () {
                  context.navigateToAndFinish(const MainLayout(
                    index: 2,
                  ));
                },
                child: Container(
                  height: SizeConfig.bodyHeight * .07,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * 0.04,
                      vertical: SizeConfig.bodyHeight * .01),
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * .04,
                      vertical: SizeConfig.bodyHeight * .02),
                  decoration: BoxDecoration(
                      color: context.colorScheme.primary,
                      borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(
                        text: context.localizations.cart,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      6.horizontalSpace,
                      AppImage.asset(
                        Assets.icons.cart,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              );
            }
            if (bloc.cartItem.productModel?.qty == 0) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: SizeConfig.bodyHeight * .02,
                  right: SizeConfig.screenWidth * .04,
                  left: SizeConfig.screenWidth * .04,
                ),
                child: CustomButton(
                  text: context.localizations.tellMeWhenProduct,
                  press: () {},
                  height: 45.h,
                ),
              );
            } else {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: SizeConfig.screenWidth * .04,
                  ),
                  QuantityDesign(
                    callback: (p0) {
                      int count = p0['count'];
                      CartItem cart = bloc.cartItem.copyWith(
                        qty: p0['count'],
                        currentItemPrice: count * bloc.cartItem.price!.toInt(),
                      );

                      bloc.updateCartItem(item: cart);
                    },
                    isProductDetails: true,
                    count: 1,
                    buttonSize: 25,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        final cartCubit = context.read<CartCubit>();

                        final List<ProductAttributes> attributesList =
                            bloc.selectedValues.entries.map((entry) => ProductAttributes(
                                      attribute: entry.key,
                                      attributeValues: entry.value,
                                    ))
                                .toList();
                        CartItem item = bloc.cartItem.copyWith(productAttributes: attributesList);

                        if(cartCubit.cartList.isNotEmpty){
                          if (cartCubit.cartList.first.productModel?.supplier?.id != widget.productModel.supplier?.id) {
                            ProductHelper().showSupplierWarningDialog(context,
                                currentSupplierName: cartCubit.cartList.first.productModel?.supplier?.name ?? "",
                                newSupplierName: widget.productModel.supplier?.name ?? "",
                                newItem: item);
                            return;
                          }
                        }

                        context.read<CartCubit>().addToCart(
                              item,
                            );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * 0.04,
                            vertical: SizeConfig.bodyHeight * .01),
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * .04,
                            vertical: SizeConfig.bodyHeight * .02),
                        decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(14)),
                        child: Row(
                          children: [
                            Expanded(
                                child: AppText(
                              text: context.localizations.addToCart,
                              color: Colors.white,
                            )),
                            AppText(
                              text:
                                  "${formatPrice(price: bloc.cartItem.currentItemPrice.toString())} ${context.localizations.iqd}",
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        );
      },
    ),
    );
  }


  void initProduct() async {
    final isIn = await context.read<CartCubit>().checkIfProductInCart(
        productId:
            context.read<ProductDetailsCubit>().cartItem.uniqueProductId ?? '');
    setState(() => isExists = isIn['inCart']);
  }
}
