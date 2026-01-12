import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/user/main/presentation/cubit/main/main_cubit.dart';
import 'package:taxito/features/user/order/presentation/widgets/cart/cart_body.dart';
import 'package:taxito/features/user/product/presentation/cubit/favourite/favourite_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../widgets/custom_app_bar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<MainCubit>().changeCurrentBottomNavIndex(currentIndex: 0);
      },
      child: BlocProvider(
        create: (context) => sl<FavouriteCubit>(),
        child: Scaffold(
          appBar: CustomAppBar(
            title: context.localizations.cart,
            showBackButton: false,
          ),
          body: const CartBody(),
        ),
      ),
    );
  }
}
