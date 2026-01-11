import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/features/order/presentation/bloc/orders/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../widgets/custom_app_bar.dart';
import '../bloc/track/track_order_cubit.dart';
import '../widgets/orders/my_orders_body.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<OrdersCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<TrackOrderCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar(
          showBackButton: false,
          title: context.localizations.orders,
        ),
        body: const MyOrdersBody(),
      ),
    );
  }
}
