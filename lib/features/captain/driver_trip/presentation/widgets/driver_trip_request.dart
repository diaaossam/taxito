import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/features/captain/driver_trip/driver_trip_helper.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/data/models/trip_model.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../driver_main/presentation/cubit/driver_trip_actions/driver_trip_actions_cubit.dart';
import 'trip_location_info.dart';

class DriverTripRequest extends StatelessWidget {
  final TripModel tripModel;
  final Function(Map<String, dynamic>) tripModelCallBack;
  final VoidCallback onCancel;

  const DriverTripRequest({
    super.key,
    required this.tripModel,
    required this.tripModelCallBack,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DriverTripActionsCubit>()..listenToActions(),
      child: BlocConsumer<DriverTripActionsCubit, DriverTripActionsState>(
        listener: (context, state) {
          if (state is RejectTripRequestSuccessState ||
              state is UserCanceledTripState) {
            onCancel.call();
          } else if (state is AcceptTripSuccess) {
            tripModelCallBack({"trip": state.tripModel, "map": state.map});
          }
        },
        builder: (context, state) {
          final bloc = context.read<DriverTripActionsCubit>();
          return Scaffold(
            body: Container(
              height: SizeConfig.bodyHeight*0.8,
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.bodyHeight * .013,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * .02,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.bodyHeight * .02),
                  Center(
                    child: AppText(
                      text: context.localizations.deleiveryRequests,
                      fontWeight: FontWeight.w600,
                      textSize: 16,
                    ),
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * .02),
                  TripLocationInfo(
                    currentLocation: bloc.currentLocation,
                    tripModel: tripModel,
                    showDistance: true,
                    showActions: false,
                    onCallBack: (p0) {},
                    onCancelTrip: (p0) {
                      if (p0) {
                        bloc.rejectTrip(tripModel: tripModel);
                      }
                    },
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * .03),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: context.localizations.accept,
                          press: () => bloc.acceptTrip(tripModel: tripModel),
                          height: 50.h,
                          backgroundColor: context.colorScheme.tertiary,
                          borderColor: context.colorScheme.tertiary,
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: CustomButton(
                          text: context.localizations.reject,
                          press: () async {
                            final response = await DriverTripHelper()
                                .showCancelTripDialog(context: context);
                            if (response) {
                              bloc.rejectTrip(tripModel: tripModel);
                            }
                          },
                          borderColor: context.colorScheme.error,
                          backgroundColor: Colors.transparent,
                          textColor: context.colorScheme.error,
                          height: 50.h,
                        ),
                      ),
                    ],
                  ),
                ],
              ).scrollable(),
            ),
          );
        },
      ),
    );
  }
}
