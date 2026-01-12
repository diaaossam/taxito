import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/user/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCartButton extends StatelessWidget {
  const ProductCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final bloc = context.read<CartCubit>();
        if (bloc.totalCount == 0) {
          return const SizedBox.shrink();
        }
       return CustomButton(text: context.localizations.placeOrder, press: (){});
      },
    );
  }
}
