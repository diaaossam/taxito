import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../widgets/custom_app_bar.dart';
import '../../../main/presentation/cubit/delivery_main/delivery_main_cubit.dart';
import '../widgets/product_body.dart';

class MyProductScreen extends StatelessWidget {
  const MyProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        context.read<DeliveryMainCubit>().changeBottomNavIndex(index: 0);
      },
      child: Scaffold(
        appBar: CustomAppBar(
          showBackButton: false,
          title: context.localizations.products,
        ),
        body: const ProductBody(),
      ),
    );
  }
}
