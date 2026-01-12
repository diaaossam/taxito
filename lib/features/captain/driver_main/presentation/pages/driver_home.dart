import 'package:taxito/features/captain/driver_trip/driver_trip_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/core/data/models/user_model.dart';
import '../../../driver_trip/data/models/trip_model.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../cubit/driver_home/driver_home_cubit.dart';
import '../widgets/driver_location/driver_location_widget.dart';

class DriverHome extends StatefulWidget {
  final TripModel? tripModel;
  final UserModel? userModel;

  const DriverHome({super.key, this.tripModel, this.userModel});

  @override
  State<DriverHome> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHome> {
  bool _isBottomSheetOpenOnInit = false;

  @override
  void initState() {
    if (widget.tripModel != null && !_isBottomSheetOpenOnInit) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          if (widget.tripModel != null) {
            DriverTripHelper().showTripBottomNav(context: context, model: widget.tripModel!,onCancel: () {
                  Future.delayed(const Duration(milliseconds: 700),() => Navigator.pop(context),);
                },)
                .then((_) {
              _isBottomSheetOpenOnInit = false;
            });
          }
        },
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<DriverHomeCubit, DriverHomeState>(
          builder: (context, state) {
            final bloc = context.read<DriverHomeCubit>();
            return Scaffold(
              body: SafeArea(
                child: DriverLocationWidget(
                  tripModel: widget.tripModel,
                  callbackAvailability: (chooseEnum) =>
                      bloc.listenToTripsRequests(
                    isAvailable: chooseEnum,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
