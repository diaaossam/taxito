import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/features/trip/presentation/widgets/request_trip/comminucation_with_driver_widget.dart';
import 'package:aslol/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/enum/trip_status_enum.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../data/models/trip_model.dart';
import '../../bloc/accepted_user_trip/accepted_user_trip_cubit.dart';
import '../../bloc/trip_info/trip_bloc.dart';
import '../../pages/report_trip_screen.dart';
import '../trip_distance_info.dart';
import 'trip_user_info_widget.dart';

class FoundDriverPage extends StatefulWidget {
  final TripModel tripModel;
  final Function(TripModel) onTripCallBack;

  const FoundDriverPage(
      {super.key, required this.tripModel, required this.onTripCallBack});

  @override
  State<FoundDriverPage> createState() => _FoundDriverPageState();
}

class _FoundDriverPageState extends State<FoundDriverPage> {
  TripModel? tripModel;

  @override
  void initState() {
    tripModel = widget.tripModel;
    context
        .read<AcceptedUserTripCubit>()
        .joinUserToTripRoom(model: widget.tripModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcceptedUserTripCubit, AcceptedUserTripState>(
      listener: (context, state) {
        final bloc = context.read<AcceptedUserTripCubit>();
        if (state is ListenToUserLocation) {
          context.read<TripBloc>().getDriverLocationEvent(
              lat: state.driverLat, lng: state.driverLng);
        }
        if (state is UpdateTripStatesState) {
          widget.onTripCallBack(bloc.tripModel ?? widget.tripModel);
        }
        if (state is AcceptedUserTripError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<AcceptedUserTripCubit>();
        if (bloc.tripModel == null) {
          return const LoadingWidget();
        }
        return Container(
            width: SizeConfig.screenWidth,
            padding: screenPadding(),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              color: context.colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                if (!context
                    .read<AcceptedUserTripCubit>()
                    .socketService
                    .isConnected()) ...[
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.orange.withOpacity(0.3)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.wifi_off, color: Colors.orange, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'Connecting...',
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * .01),
                ],
                AppText(
                  text: handleTripStatusEnumToString(
                      tripStatusEnum: bloc.tripModel!.status ??
                          TripStatusEnum.waitingDriver),
                  fontWeight: FontWeight.bold,
                  textSize: 14,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.colorScheme.outline,
                      ),
                      color: context.colorScheme.onPrimary),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: context.colorScheme.primary)),
                            child: CircleAvatar(
                              maxRadius: 25,
                              backgroundImage: NetworkImage(
                                  bloc.tripModel?.driver?.image ?? ""),
                              onBackgroundImageError: (exception, stackTrace) =>
                                  AssetImage(Assets.images.dummyUser.path),
                            ),
                          ),
                          10.horizontalSpace,
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: SizeConfig.bodyHeight * .01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: AppText(
                                      text: "${bloc.tripModel?.driver?.name}",
                                      fontWeight: FontWeight.w600,
                                      textSize: 13,
                                    ),
                                  ),
                                  ComminucationWithDriverWidget(
                                    tripModel: bloc.tripModel!,
                                    onCallBack: (p0) => bloc.getTripByUuid(
                                        id: widget.tripModel.id ?? 0),
                                  ),
                                ],
                              ),
                              TripInfoWidget(
                                tripModel: bloc.tripModel!,
                              ),
                              10.verticalSpace,
                            ],
                          )),
                        ],
                      ),
                      TripDistanceInfo(
                        tripModel: tripModel ?? widget.tripModel,
                        color: context.colorScheme.onPrimary,
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,
                TextButton(
                  onPressed: () {
                    context.navigateTo(ReportTripScreen(
                      tripModel: tripModel ?? widget.tripModel,
                    ));
                  },
                  child: Center(
                    child: AppText(
                      text: context.localizations.doYouNeedToReport,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.error,
                      textSize: 13,
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
