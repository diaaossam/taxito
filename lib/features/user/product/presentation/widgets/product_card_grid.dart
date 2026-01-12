import 'package:animations/animations.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:taxito/features/user/order/data/models/cart_model.dart';
import 'package:taxito/features/user/order/order_helper.dart';
import 'package:taxito/features/user/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:taxito/features/user/product/presentation/cubit/product/product_cubit.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_details/like_button.dart';
import 'package:taxito/features/user/product/presentation/widgets/quantity_design.dart';
import 'package:taxito/features/user/product/product_helper.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/core/data/models/product_model.dart';
import '../pages/product_details.dart';

class ProductCardGrid extends StatefulWidget {
  final ProductModel productModel;
  final double? imageHeight, imageWidth;
  final VoidCallback? onTap;
  final VoidCallback? onReload;
  final EdgeInsetsGeometry? margin;
  final num? supplierId;
  final bool isLiked;
  final bool withExpandedText;
  final Function(bool) onTapped;

  const ProductCardGrid({
    super.key,
    required this.productModel,
    this.imageHeight,
    this.imageWidth,
    this.onTap,
    this.margin,
    this.supplierId,
    this.withExpandedText = false,
    required this.isLiked,
    required this.onTapped, this.onReload,
  });

  @override
  State<ProductCardGrid> createState() => _ProductCardGridState();
}

class _ProductCardGridState extends State<ProductCardGrid> {
  int currentQuantity = 0;
  final GlobalKey<QuantityDesignState> requestKey =
  GlobalKey<QuantityDesignState>();

  @override
  void initState() {
    super.initState();
    _loadCartQuantity();
  }

  void _loadCartQuantity() {
    final cartCubit = context.read<CartCubit>();
    final uniqueId = ProductHelper().formatUniqueId(
        productId: widget.productModel.id ?? 0, listOfValues: []);

    final existingItem = cartCubit.cartList.firstWhere(
          (item) => item.uniqueProductId == uniqueId,
      orElse: () => CartItem(),
    );

    if (existingItem.qty != null) {
      setState(() => currentQuantity = existingItem.qty!.toInt());
    }
  }

  void _handleQuantityChange(Map<String, dynamic> info) async{
    final cartCubit = context.read<CartCubit>();
    final uniqueId = ProductHelper().formatUniqueId(productId: widget.productModel.id ?? 0, listOfValues: []);
    final cartItem = CartItem(
      productId: widget.productModel.id,
      qty: 1,
      price: widget.productModel.price,
      currentItemPrice: widget.productModel.price,
      uniqueProductId: uniqueId,
      productModel: widget.productModel,
    );
    if (info['isAdd'] == true) {
      if (cartCubit.cartList.isNotEmpty) {
        if (cartCubit.cartList.first.productModel?.supplier?.id !=
            widget.productModel.supplier?.id) {
          requestKey.currentState!.resetCount();
        final response= await ProductHelper().showSupplierWarningDialog(context,
              currentSupplierName:
              cartCubit.cartList.first.productModel?.supplier?.name ?? "",
              newSupplierName: widget.productModel.supplier?.name ?? "",
              newItem: cartItem);
        if(response){
          if(widget.onReload != null){
            widget.onReload!.call();
          }
          context.read<ProductCubit>().bestOffersController.refresh();
          context.read<ProductCubit>().mostSellingController.refresh();
          context.read<ProductCubit>().recommendedController.refresh();
        }
          return;
        }
      }
      cartCubit.addToCart(cartItem);
      setState(() => currentQuantity = 1);
    }
    else if (info['isDelete'] == true || info['count'] == 0) {
      cartCubit.deleteItemFromCart(id: uniqueId);
      setState(() => currentQuantity = 0);
    }
    else {
      cartCubit.setQuantity(
        productId: uniqueId,
        isIncrease: info['isIncrease'],
      );
      setState(() => currentQuantity = info['count']);
    }
  }


@override
Widget build(BuildContext context) {
  return BlocListener<CartCubit, CartState>(
    listener: (context, state) {
      if (state is SetQuantityStateSuccess ||
          state is AddCartListStateSuccess ||
          state is DeleteItemFromCartSuccess) {
        _loadCartQuantity();
      }
    },
    child: OpenContainer(
      closedBuilder: (context, action) =>
          Container(
            margin: widget.margin,
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * .02),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AppImage.network(
                        height: widget.imageHeight ??
                            SizeConfig.bodyHeight * .18,
                        width: widget.imageWidth ??
                            SizeConfig.screenWidth * .38,
                        remoteImage: widget.productModel.images?.first.url,
                        fit: BoxFit.cover,
                      ),
                    ),
                    if (widget.productModel.percentageDiscount != 0)
                      Positioned.directional(
                        textDirection: TextDirection.ltr,
                        top: 20,
                        start: -5,
                        child: Transform.rotate(
                          angle: -0.2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: context.colorScheme.onPrimaryFixed,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                    '${widget.productModel
                                        .percentageDiscount}%',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10.sp,
                                      fontFamily: AppStrings.arabicFont,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' OFF',
                                    style: TextStyle(
                                      fontSize: 8.sp,
                                      fontFamily: AppStrings.arabicFont,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    Positioned.directional(
                      end: 5,
                      top: 5,
                      textDirection: TextDirection.ltr,
                      child: LikeButtonDesign(
                        onTapped: widget.onTapped,
                        isLiked: widget.isLiked,
                      ),
                    ),
                    Positioned.directional(
                      end: 5,
                      bottom: 5,
                      textDirection: TextDirection.ltr,
                      child: QuantityDesign(
                        key: requestKey,
                        buttonSize: 18.sp,
                        isProductDetails: false,
                        isCard: true,
                        callback: _handleQuantityChange,
                        count: currentQuantity,
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
                SizedBox(
                  width: widget.imageWidth ?? SizeConfig.screenWidth * .38,
                  child: AppText(
                    text: widget.productModel.title ?? "",
                    textSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                10.verticalSpace,
                Row(
                  children: [
                    AppText(
                      text:
                      "${formatPrice(price: widget.productModel.price
                          .toString())} ${context.localizations.iqd}",
                      textSize: 9,
                      fontWeight: FontWeight.w600,
                    ),
                    10.horizontalSpace,
                    if (widget.productModel.oldPrice != null &&
                        widget.productModel.oldPrice != 0) ...{
                      AppText(
                        text:
                        "${formatPrice(price: widget.productModel.oldPrice
                            .toString())} ${context.localizations.iqd}",
                        color: context.colorScheme.shadow,
                        textSize: 8,
                        textDecoration: TextDecoration.lineThrough,
                      ),
                      10.horizontalSpace,
                    },
                  ],
                ),
                if (widget.productModel.supplier != null) ...{
                  10.verticalSpace,
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: AppImage.network(
                          width: SizeConfig.bodyHeight * .035,
                          height: SizeConfig.bodyHeight * .035,
                          fit: BoxFit.cover,
                          remoteImage: widget.productModel.supplier?.logo,
                        ),
                      ),
                      7.horizontalSpace,
                      if (widget.withExpandedText)
                        Expanded(
                          child: AppText(
                            text: widget.productModel.supplier?.name ?? "",
                            textSize: 10,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      else
                        AppText(
                          text: widget.productModel.supplier?.name ?? "",
                          textSize: 10,
                          maxLines: 2,
                          fontWeight: FontWeight.w600,
                        )
                    ],
                  ),
                }
              ],
            ),
          ),
      openBuilder: (context, action) =>
          ProductDetailsScreen(
            productModel: widget.productModel,
            supplierId: widget.supplierId,
            productId: widget.productModel.id,
          ),
    ),
  );
}}
