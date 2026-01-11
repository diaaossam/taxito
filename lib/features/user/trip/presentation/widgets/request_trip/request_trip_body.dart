import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/features/trip/trip_helper.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../bloc/trip_info/trip_bloc.dart';
import '../../bloc/trip_info/trip_state.dart';
import '../../pages/choose_location_screen.dart';

class RequestTripBody extends StatelessWidget {
  final Function(int) onChangeIndex;
  const RequestTripBody({
    super.key, required this.onChangeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      builder: (context, state) {
        final bloc = context.read<TripBloc>();
        return Container(
            width: SizeConfig.screenWidth,
            padding: screenPadding(),
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
              color: context.colorScheme.surface,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                AppText(
                  text: bloc.currentState ==0?context.localizations.startPoint:context.localizations.endPoint,
                  textSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
                CustomTextFormField(
                  readOnly: true,
                  controller: TextEditingController(text: bloc.startLocation?.place),
                  onTap: () async {
                    final response = await TripHelper()
                        .searchForLocation(context: context, isStart: true);
                    if (response != null) {
                      bloc.submitTripPointEvent(
                          mainLocationData: response, isStart: true);
                    }
                  },
                  hintText: context.localizations.currentLocation,
                  prefixIcon: AppImage.asset(
                    Assets.icons.location,
                    color: context.colorScheme.primary,
                  ),
                ),
                if (bloc.currentState == 1 || bloc.currentState == 2) ...{
                  SizedBox(
                    height: SizeConfig.bodyHeight * .02,
                  ),
                  CustomTextFormField(
                    readOnly: true,
                    controller:
                        TextEditingController(text: bloc.endLocation?.place),
                    onTap: () {
                      context.navigateTo(
                        const ChooseLocationScreen(
                          isStart: false,
                        ),
                        callback: (p0) {
                          if (p0 != null) {
                            bloc.submitTripPointEvent(
                                mainLocationData: p0, isStart: false);
                          }
                        },
                      );
                    },
                    hintText: context.localizations.whereAreYouGoing,
                    prefixIcon: AppImage.asset(
                      Assets.icons.location,
                      color: context.colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.bodyHeight * .02,
                  ),
                },
                const Spacer(),
                CustomButton(
                  isActive: _isButtonEnabled(bloc),
                    text: bloc.currentState == 0
                        ? context.localizations.confirmStartPoint
                        : context.localizations.confirmArrivePoint,
                    press: () {
                      if (bloc.currentState == 0) {
                        bloc.changeCurrentState(1);
                        return;
                      }
                      if (bloc.currentState == 1) {
                        bloc.changeCurrentState(2);
                        onChangeIndex(1);
                        return;
                      }
                    }),
                SizedBox(
                  height: SizeConfig.bodyHeight * .02,
                ),
              ],
            ));
      },
    );
  }
  bool _isButtonEnabled(TripBloc bloc) {
    if (bloc.currentState == 1) {
      return bloc.endLocation?.place.isNotEmpty ?? false;
    }
    return true;
  }
}
