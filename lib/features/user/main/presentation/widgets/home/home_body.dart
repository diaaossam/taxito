import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:aslol/features/product/presentation/cubit/product/product_cubit.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../food/presentation/pages/food_main_screen.dart';
import '../../../../trip/presentation/pages/request_trip_screen.dart';
import 'banners_design.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  @override
  void initState() {
    context.read<CartCubit>().getCartData(isRemote: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: screenPadding(),
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                    const HomeBannersImage(),
                    SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                    InkWell(
                      onTap: () => context.navigateTo(const FoodMainScreen()),
                      child: Stack(
                        children: [
                          AppImage.asset(Assets.images.foodBanner.path),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: SizeConfig.screenWidth * .45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: SizeConfig.bodyHeight * .04,
                                ),
                                AppText(
                                  text: context.localizations.banners1,
                                  textSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  maxLines: 2,
                                  align: TextAlign.center,
                                ),
                                SizedBox(
                                  height: SizeConfig.bodyHeight * .02,
                                ),
                                AbsorbPointer(
                                  absorbing: true,
                                  child: CustomButton(
                                      height: 50,
                                      backgroundColor: Colors.white,
                                      textColor: context.colorScheme.primary,
                                      text: context.localizations.orderNow,
                                      press: () {}),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                    InkWell(
                      onTap: () =>
                          context.navigateTo(const RequestTripScreen()),
                      child: Stack(
                        children: [
                          AppImage.asset(Assets.images.taxiBanner.path),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            width: SizeConfig.screenWidth * .45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: SizeConfig.bodyHeight * .04,
                                ),
                                AppText(
                                  text: context.localizations.banners2,
                                  textSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  maxLines: 2,
                                  align: TextAlign.center,
                                ),
                                SizedBox(
                                  height: SizeConfig.bodyHeight * .02,
                                ),
                                AbsorbPointer(
                                  absorbing: true,
                                  child: CustomButton(
                                      height: 50,
                                      backgroundColor: Colors.white,
                                      textColor: context.colorScheme.primary,
                                      text: context.localizations.orderNow,
                                      press: () {}),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
