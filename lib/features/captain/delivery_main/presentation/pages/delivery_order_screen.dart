import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/delivery_order/presentation/widgets/delivery_order_body.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../delivery_order/presentation/cubit/delivery_actions/delivery_actions_cubit.dart';
import '../../../delivery_order/presentation/cubit/delivery_order_cubit.dart';

class DeliveryOrderScreen extends StatelessWidget {
  const DeliveryOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<DeliveryOrderCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<DeliveryActionsCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          showBackButton: false,
          title: context.localizations.myOrders,
        ),
        body: Padding(
          padding: screenPadding(),
          child: const DeliveryOrderBody(
            showTitle: false,
          ),
        ),
      ),
    );
  }
}
