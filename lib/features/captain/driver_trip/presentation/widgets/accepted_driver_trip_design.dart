import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/enum/trip_status_enum.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../driver_main/presentation/pages/driver_main_layout.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/settings_helper.dart';
import '../../data/models/trip_model.dart';
import '../../driver_trip_helper.dart';
import '../bloc/accepted_driver_trip/accepted_driver_cubit.dart';
import 'trip_location_info.dart';

class AcceptedDriverTrip extends StatefulWidget {
  final TripModel tripModel;
  final Map<String, dynamic> map;
  final Function(TripModel) onTripCallBack;

  const AcceptedDriverTrip({
    super.key,
    required this.tripModel,
    required this.map,
    required this.onTripCallBack,
  });

  @override
  State<AcceptedDriverTrip> createState() => _AcceptedDriverTripState();
}

class _AcceptedDriverTripState extends State<AcceptedDriverTrip> {
  TripModel? tripModel;

  @override
  void initState() {
    tripModel = widget.tripModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AcceptedDriverCubit>()
        ..joinDriverToTripRoom(
          tripId: tripModel!.uuid.toString(),
          tripData: widget.map,
        ),
      child: BlocConsumer<AcceptedDriverCubit, AcceptedDriverState>(
        listener: (context, state) {
          if (state is ListenToTripPaymentCashState) {
            DriverTripHelper().showConfirmationPaymentDialog(
                context: context, tripModel: tripModel!);
          } else if (state is UpdateTripSuccess) {
            if (state.isCancel) {
              Navigator.of(context).pop();
              return;
            } else if (state.isDelivered) {
              if (tripModel?.paymentMethod == PaymentType.wallet) {
                if (state.tripModel.remaining_price != null &&
                    state.tripModel.remaining_price != 0) {
                } else {
                  context.navigateToAndFinish(const DriverMainLayout());
                }
              }
            }
            setState(() => tripModel = state.tripModel);
          } else if (state is GetTripByIdSuccess) {
            setState(() => tripModel = state.tripModel);
          } else if (state is UpdateTripFailed) {
            AppConstant.showCustomSnakeBar(context, state.msg, false);
          } else if (state is AcceptPaymentRequestSuccess) {
            context.navigateToAndFinish(const DriverMainLayout());
          }
        },
        builder: (context, state) {
          final bloc = context.read<AcceptedDriverCubit>();
          return Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeConfig.screenWidth * .04,
                vertical: SizeConfig.bodyHeight * .013),
            margin:
                EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .02),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 2), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                AppText(
                  text: handleTripStatusEnumToString(
                      tripStatusEnum:
                          tripModel!.status ?? TripStatusEnum.waitingDriver),
                  fontWeight: FontWeight.bold,
                  textSize: 15,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                TripLocationInfo(
                  showDistance: false,
                  tripModel: tripModel!,
                  showActions: true,
                  onCallBack: (p0) =>
                      bloc.getTripModelByUuid(id: widget.tripModel.id ?? 0),
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                if (tripModel?.status == TripStatusEnum.delivered)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AppText(
                            text: context.localizations.waitUserToPay,
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            textSize: 13,
                            color: context.colorScheme.primary,
                          ),
                          5.horizontalSpace,
                          AppText(
                            text: tripModel!.totalPrice != null
                                ? tripModel!.totalPrice!.toString()
                                : "0",
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            color: context.colorScheme.primary,
                            textSize: 16,
                          ),
                          5.horizontalSpace,
                          AppText(
                            text: context.localizations.iqd,
                            fontWeight: FontWeight.bold,
                            maxLines: 2,
                            color: context.colorScheme.primary,
                            textSize: 13,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.bodyHeight * .02,
                      ),
                      GestureDetector(
                        onTap: () {
                          context
                              .read<AcceptedDriverCubit>()
                              .acceptPaymentRequest(
                                  driverAcceptConfirmation: false,
                                  tripId: tripModel?.uuid ?? "",
                                  id: tripModel?.id ?? 0.0);
                          Future.delayed(
                            const Duration(milliseconds: 600),
                            () {
                              SettingsHelper.contactUsWithPhoneNumber(
                                  phoneNumber: context
                                          .read<SettingsBloc>()
                                          .settingsModel!
                                          .firstPhone ??
                                      "");
                            },
                          );
                        },
                        child: AppText(
                          text: context.localizations.haveProblem,
                          color: context.colorScheme.error,
                          maxLines: 2,
                          fontWeight: FontWeight.bold,
                          textSize: 13,
                          align: TextAlign.center,
                        ),
                      ),
                    ],
                  )
                else ...{
                  CustomButton(
                      text: _getButtonText(),
                      press: () async {
                        if (tripModel!.status == TripStatusEnum.pickingClient) {
                          await bloc.updateTripStatus(
                              id: widget.tripModel.id ?? 0,
                              status: TripStatusEnum.pickedClient,
                              uuid: widget.tripModel.uuid ?? "");
                        }
                        if (tripModel!.status == TripStatusEnum.pickedClient) {
                          await bloc.updateTripStatus(
                              id: widget.tripModel.id ?? 0,
                              status: TripStatusEnum.started,
                              uuid: widget.tripModel.uuid ?? "");
                        }
                        if (tripModel!.status == TripStatusEnum.started) {
                          await bloc.updateTripStatus(
                              id: widget.tripModel.id ?? 0,
                              status: TripStatusEnum.delivered,
                              uuid: widget.tripModel.uuid ?? "");
                        }
                      }),
                  10.verticalSpace,
                  CustomButton(
                      text: context.localizations.cancel,
                      backgroundColor: context.colorScheme.error,
                      borderColor: context.colorScheme.error,
                      press: () async {
                        bool isCancel =
                            await DriverTripHelper().showCancelTripDialog(
                          context: context,
                        );
                        if (isCancel) {
                          bloc.updateTripStatus(
                              status: TripStatusEnum.cancelled,
                              id: widget.tripModel.id ?? 0,
                              uuid: widget.tripModel.uuid ?? "");
                        }
                      }),
                },
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _getButtonText() {
    switch (tripModel?.status) {
      case null:
        return context.localizations.pickedClient;
      case TripStatusEnum.coming:
        return context.localizations.pending;
      case TripStatusEnum.waitingDriver:
        return context.localizations.pickedClient;
      case TripStatusEnum.cancelled:
        return context.localizations.cancelled;
      case TripStatusEnum.pickedClient:
        return context.localizations.startTrip;
      case TripStatusEnum.pickingClient:
        return context.localizations.pickedClient;
      case TripStatusEnum.delivered:
        return context.localizations.delivered;
      case TripStatusEnum.started:
        return context.localizations.endTrip;
    }
  }
}
