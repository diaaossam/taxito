import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/user/product/presentation/widgets/product_details/like_button.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_failure.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/utils/api_config.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import 'package:taxito/features/common/models/product_model.dart';
import '../../../../captain/settings/settings_helper.dart';
import '../cubit/favourite/favourite_cubit.dart';
import '../cubit/product_details/product_details_cubit.dart';
import '../widgets/product_details/product_details_body.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel productModel;
  final num? productId;
  final num? supplierId;

  const ProductDetailsScreen({
    super.key,
    required this.productModel,
    this.productId,
    this.supplierId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (productId != null && supplierId != null) {
          return sl<ProductDetailsCubit>()..getProductDetailsById(
            productId: productId!,
            supplierId: supplierId!,
          );
        } else {
          return sl<ProductDetailsCubit>()..getProductDetailsById(
            model: productModel,
            supplierId: productModel.supplier?.id ?? 0,
            productId: productModel.id ?? 0,
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.localizations.productDetails,
          actions: [
            BlocProvider(
              create: (context) => sl<FavouriteCubit>(),
              child: BlocConsumer<FavouriteCubit, FavouriteState>(
                listener: (context, state) {
                  if (state is ToggleFavouriteSuccess) {
                    AppConstant.showCustomSnakeBar(context, state.msg, true);
                  }
                  if (state is ToggleFavouriteFailure) {
                    AppConstant.showCustomSnakeBar(context, state.msg, false);
                  }
                },
                builder: (context, state) {
                  return LikeButtonDesign(
                    showBorder: true,
                    onTapped: (isLiked) {
                      if(ApiConfig.isGuest == true){
                        SettingsHelper().showGuestDialog(context);
                        return false;
                      }
                      productModel.isAddedToFavourite = isLiked;
                      context.read<FavouriteCubit>().toggleWishlist(
                        id: productModel.id ?? 0,
                        type: "product",
                      );
                    },
                    isLiked: productModel.isAddedToFavourite ?? false,
                  );
                },
              ),
            ),
            10.horizontalSpace,
          ],
          pressIcon: () => Navigator.pop(context),
        ),
        body: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            if (productId != null) {
              if (state is GetProductDetailsSuccess) {
                return ProductDetailsBody(
                  productModel: state.productModel.copyWith(
                    supplier: productModel.supplier,
                  ),
                );
              } else if (state is GetProductDetailsLoading) {
                return const LoadingWidget();
              } else {
                return AppFailureWidget(
                  height: SizeConfig.bodyHeight * .2,
                  image: Assets.images.noNetwork.path,
                  title: context.localizations.noInternetConnection,
                  body: context.localizations.tryAgainLater,
                  callback: () {},
                  buttonText: context.localizations.tryAgain,
                );
              }
            } else {
              return ProductDetailsBody(
                productModel: productModel.copyWith(
                  supplier: productModel.supplier,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
