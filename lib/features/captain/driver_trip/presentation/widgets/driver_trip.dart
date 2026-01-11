import 'package:taxito/core/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/enum/trip_status_enum.dart';
import '../../data/models/trip_model.dart';
import '../bloc/trip/trip_cubit.dart';
import 'accepted_driver_trip_design.dart';
import 'driver_trip_request.dart';

class DriverTripWidget extends StatefulWidget {
  final TripModel tripModel;
  final VoidCallback onCancel;

  const DriverTripWidget({
    super.key,
    required this.tripModel,
    required this.onCancel,
  });

  @override
  State<DriverTripWidget> createState() => _DriverTripWidgetState();
}

class _DriverTripWidgetState extends State<DriverTripWidget> {
  TripModel? tripModel;
  Map<String, dynamic> map = {};

  double height = SizeConfig.bodyHeight * 0.7;

  @override
  void initState() {
    tripModel = widget.tripModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: BlocProvider(
        create: (context) => sl<TripCubit>(),
        child: BlocBuilder<TripCubit, TripState>(
          builder: (context, state) {
            final bloc = context.read<TripCubit>();
            if (tripModel?.status == TripStatusEnum.waitingDriver) {
              return DriverTripRequest(
                tripModel: widget.tripModel,
                onCancel: widget.onCancel,
                tripModelCallBack: (data) {
                  setState(() {
                    tripModel = data['trip'];
                    map = data['map'];
                  });
                  bloc.updateTripModel(model: data['trip']);
                },
              );
            } else {
              return AcceptedDriverTrip(
                onTripCallBack: (p0) => setState(() => tripModel = p0),
                tripModel: tripModel ?? widget.tripModel,
                map: map,
              );
            }
          },
        ),
      ),
    );
  }
}
