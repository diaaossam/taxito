import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/captain/driver_trip/presentation/widgets/trips_history/trip_history_body.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/data/models/trip_model.dart';
import '../bloc/driver_history/trip_history_details_cubit.dart';

class DriverHistoryDetailsScreen extends StatelessWidget {
  final TripModel tripModel;

  const DriverHistoryDetailsScreen({super.key, required this.tripModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TripHistoryDetailsCubit>()..initPolyline(tripModel: tripModel),
      child: BlocConsumer<TripHistoryDetailsCubit, TripHistoryDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final bloc = context.read<TripHistoryDetailsCubit>();
          return Scaffold(
            appBar: CustomAppBar(title: context.localizations.tripDetails,),
            body: TripHistoryBody(tripModel: tripModel),
          );
        },
      ),
    );
  }
}
