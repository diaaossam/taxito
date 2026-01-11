import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/order/data/models/cart_model.dart';
import 'package:aslol/features/product/presentation/cubit/product_details/product_details_cubit.dart';
import 'package:aslol/features/product/product_helper.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TypeNoteWidget extends StatelessWidget {
  const TypeNoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              AppImage.asset(
                Assets.icons.messageQuestion,
              ),
              6.horizontalSpace,
              AppText(
                text: context.localizations.doYouHaveAnyNote,
                textSize: 12,
              ),
            ],
          ),
        ),
        BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, state) {
            return InkWell(
              onTap: () async {
                final data =
                    await ProductHelper().showNoteProduct(context: context);
                CartItem cart = context
                    .read<ProductDetailsCubit>()
                    .cartItem
                    .copyWith(notes: data);
                context.read<ProductDetailsCubit>().updateCartItem(item: cart);
              },
              child: AppText(
                text: context.localizations.writeItHere,
                fontWeight: FontWeight.w600,
                color: context.colorScheme.primary,
              ),
            );
          },
        ),
      ],
    );
  }
}
