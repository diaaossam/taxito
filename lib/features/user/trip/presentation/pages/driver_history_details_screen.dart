import 'package:aslol/core/enum/trip_status_enum.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/widget_ext.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/trip/presentation/bloc/driver_history/trip_history_details_cubit.dart';
import 'package:aslol/features/trip/presentation/widgets/driver_info_widget.dart';
import 'package:aslol/features/trip/presentation/widgets/google_map_widget.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../data/models/trip_model.dart';
import '../widgets/payment_type_info.dart';
import '../widgets/trip_distance_info.dart';
import '../widgets/trip_rating_design.dart';
import '../widgets/trips_history/driver_trip_item.dart';

class DriverHistoryDetailsScreen extends StatelessWidget {
  final TripModel tripModel;

  const DriverHistoryDetailsScreen({super.key, required this.tripModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TripHistoryDetailsCubit>()..initPolyline(tripModel: tripModel),
      child: BlocConsumer<TripHistoryDetailsCubit, TripHistoryDetailsState>(
        listener: (context, state) {},
        builder: (context, state) {
          final bloc = context.read<TripHistoryDetailsCubit>();
          return Scaffold(
            appBar: CustomAppBar(title: context.localizations.tripDetails,),
            body: Padding(
              padding: screenPadding(),
              child: Column(
                children: [
                  Container(
                    height: SizeConfig.bodyHeight*0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: context.colorScheme.outline)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: GoogleMapWidget(
                        polylines: bloc.polyines,
                        latLng: tripModel.from!.latLng,
                        markers: bloc.markers,
                      ),
                    ),
                  ),
                  DriverTripItem(tripModel: tripModel,isDriver: false,),
                  10.verticalSpace,
                  TripDistanceInfo(tripModel: tripModel,),
                  20.verticalSpace,
                  if(tripModel.driver != null)...[
                    DriverInfoWidget(driver: tripModel.driver!, trip: tripModel),
                    20.verticalSpace,
                  ],

                  PaymentTypeInfo( trip: tripModel),
                  20.verticalSpace,
                  if(tripModel.status != TripStatusEnum.cancelled)
                  TripRatingDesign(tripModel: tripModel,),
                  20.verticalSpace,
                ],
              ).scrollable(),
            ),
          );
        },
      ),
    );
  }
}
