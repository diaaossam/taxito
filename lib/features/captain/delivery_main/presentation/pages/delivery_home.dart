import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/delivery_main/presentation/pages/statics_info_design.dart';
import 'package:taxito/features/captain/location/presentation/cubit/driver_location/driver_location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../delivery_order/presentation/cubit/delivery_order_cubit.dart';
import '../../../delivery_order/presentation/widgets/delivery_order_body.dart';
import '../../../driver_main/presentation/widgets/driver_main_layout/driver_home_actions.dart';
import '../../../location/presentation/cubit/driver_location/driver_location_cubit.dart';

class DeliveryHome extends StatelessWidget {
  final num? id;

  const DeliveryHome({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<DriverLocationCubit>()..getCurrentDriverLocation(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: screenPadding(),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.bodyHeight * .02),
                BlocBuilder<DriverLocationCubit, DriverLocationState>(
                  builder: (context, state) {
                    return BlocBuilder<DeliveryOrderCubit, DeliveryOrderState>(
                      builder: (context, state) {
                        return DriverHomeActions(
                          callbackAvailability: (p0) {
                            context
                                .read<DriverLocationCubit>()
                                .getDriverStreamLocation(
                                  chooseEnum: p0,
                                  isDelivery: true,
                                );
                            context
                                .read<DeliveryOrderCubit>()
                                .listenToTripsRequests(isAvailable: p0);
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                const StaticsInfoDesign(),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                Expanded(
                  child: DeliveryOrderBody(showTitle: true, id: id),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
