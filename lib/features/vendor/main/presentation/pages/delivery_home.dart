import 'package:taxito/core/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/features/captain/delivery_main/presentation/pages/statics_info_design.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../order/presentation/cubit/delivery_actions/delivery_actions_cubit.dart';
import '../../../order/presentation/cubit/delivery_order_cubit.dart';
import '../../../order/presentation/widgets/delivery_order_body.dart';

class DeliveryHome extends StatelessWidget {
  final num? orderId;

  const DeliveryHome({super.key, this.orderId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<DeliveryOrderCubit>()),
        BlocProvider(create: (context) => sl<DeliveryActionsCubit>()),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: screenPadding(),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.bodyHeight * .02),
                const StaticsInfoDesign(),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                Expanded(
                  child: DeliveryOrderBody(showTitle: true, orderId: orderId),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
