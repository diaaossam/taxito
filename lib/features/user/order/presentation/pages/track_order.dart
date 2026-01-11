import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/features/order/presentation/bloc/track/track_order_cubit.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependencies/injectable_dependencies.dart';
import '../widgets/track_order/track_order_body.dart';

class TrackOrderScreen extends StatelessWidget {
  final num id;

  const TrackOrderScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TrackOrderCubit>()..getOrderDetails(orderId: id),
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.localizations.trackOrder,
        ),
        body: const TrackOrderBody(),
      ),
    );
  }
}
