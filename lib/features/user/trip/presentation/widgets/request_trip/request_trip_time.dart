import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/features/user/trip/trip_helper.dart';
import 'package:taxito/widgets/app_drop_down.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../domain/entities/trip_params.dart';
import '../../bloc/request_trip/request_trip_info_bloc.dart';
import '../../bloc/trip_info/trip_bloc.dart';
import '../../bloc/trip_info/trip_state.dart';

class RequestTripTime extends StatefulWidget {
  const RequestTripTime({super.key});

  @override
  State<RequestTripTime> createState() => _RequestTripTimeState();
}

class _RequestTripTimeState extends State<RequestTripTime> {
  DateTime tripDateTime = DateTime.now();
  TextEditingController date = TextEditingController();
  TextEditingController time = TextEditingController();

  @override
  void initState() {
    _initTripTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        final bloc = context.read<TripBloc>();
        return Container(
          width: SizeConfig.screenWidth,
          padding: screenPadding(),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            color: context.colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.bodyHeight * .02),
              Center(
                child: AppText(
                  text: context.localizations.startAndEndPoint,
                  textSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: date,
                      title: context.localizations.tripDate,
                      prefixIcon: AppImage.asset(Assets.icons.calendar),
                      onTap: () async {
                        final response = await TripHelper()
                            .showDatePickerWidget(context: context);
                        if (response != null) {
                          date.text = TripHelper().formatTripDate(
                            date: response,
                          );
                          setState(
                                () =>
                            tripDateTime = tripDateTime.copyWith(
                              year: response.year,
                              month: response.month,
                              day: response.day,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  20.horizontalSpace,
                  Expanded(
                    child: CustomTextFormField(
                      controller: time,
                      title: context.localizations.tripDate,
                      prefixIcon: AppImage.asset(Assets.icons.clock),
                      onTap: () async {
                        final TimeOfDay? timeOfDay = await TripHelper()
                            .showTimerPickerWidget(context: context);
                        if (timeOfDay != null) {
                          setState(() {
                            tripDateTime = tripDateTime.copyWith(
                              hour: timeOfDay.hour,
                              minute: timeOfDay.minute,
                            );
                          });
                          time.text = TripHelper().formatTripTime(
                            date: tripDateTime,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              CustomTextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: bloc.startLocation?.place,
                ),
                hintText: context.localizations.currentLocation,
                prefixIcon: AppImage.asset(
                  Assets.icons.location,
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              CustomTextFormField(
                readOnly: true,
                controller: TextEditingController(
                  text: bloc.endLocation?.place,
                ),
                hintText: context.localizations.whereAreYouGoing,
                prefixIcon: AppImage.asset(
                  Assets.icons.location,
                  color: context.colorScheme.error,
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              const Spacer(),
              BlocBuilder<RequestTripBloc, RequestTripState>(
                builder: (context, requestState) {
                  return CustomButton(
                    text: getButtonText(bloc.currentState),
                    isLoading: requestState is MakeTripRequestLoading,
                    press: () {
                      TripHelper().showPaymentMethods(
                        context: context,
                        paymentMethod: (p0) {
                          int isSchedule = checkIfScheduled(tripDateTime);
                          TripParams tripParams = TripParams(
                            tripTypeId: 1,
                            fromAddress: bloc.startLocation?.address,
                            fromLat: bloc.startLocation?.latLng.latitude,
                            fromLng: bloc.startLocation?.latLng.longitude,
                            toAddress: bloc.endLocation?.address,
                            isSchedule: isSchedule,
                            toLat: bloc.endLocation?.latLng.latitude,
                            toLng: bloc.endLocation?.latLng.longitude,
                            paymentMethod: p0,
                            tripDate: TripHelper().formatDateTimeToApi(
                              tripDateTime,
                            )['trip_date'],
                            tripTime: TripHelper().formatDateTimeToApi(
                              tripDateTime,
                            )['trip_time'],
                          );
                          context.read<RequestTripBloc>().add(
                            MakeTripRequestEvent(tripParams: tripParams),
                          );
                        },
                      );
                    },
                  );
                },
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
            ],
          ),
        );
      },
    );
  }

  void _initTripTime() {
    date.text = TripHelper().formatTripDate(date: DateTime.now());
    time.text = TripHelper().formatTripTime(date: DateTime.now());
  }

  getButtonText(int currentState) {
    if (currentState == 0) {
      return context.localizations.confirmStartPoint;
    } else if (currentState == 1) {
      return context.localizations.confirmArrivePoint;
    } else if (currentState == 2) {
      int isSchedule = checkIfScheduled(tripDateTime);
      if (isSchedule == 1) {
        return context.localizations.next;
      } else {
        return context.localizations.searchForDriver;
      }
    }
  }

  int checkIfScheduled(DateTime selectedDateTime) {
    final now = DateTime.now();
    final difference = selectedDateTime.difference(now);
    if (difference.inMinutes <= 15) {
      return 0; // حالي
    } else {
      return 1; // مؤجل
    }
  }
}
