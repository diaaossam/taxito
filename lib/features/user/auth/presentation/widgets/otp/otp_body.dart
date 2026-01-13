import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/data/models/user_model.dart';
import 'package:taxito/features/user/auth/presentation/pages/register_screen.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../../core/data/models/trip_model.dart';
import '../../../../../../core/enum/trip_status_enum.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../trip/presentation/pages/request_trip_screen.dart';
import '../../cubit/otp/otp_bloc.dart';
import 'otp_counter.dart';

class OtpVerficationWidget extends StatefulWidget {
  final String phoneNumber;
  final UserType userType;

  const OtpVerficationWidget({
    super.key,
    required this.userType,
    required this.phoneNumber,
  });

  @override
  State<OtpVerficationWidget> createState() => _OtpVerficationWidgetState();
}

class _OtpVerficationWidgetState extends State<OtpVerficationWidget> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SizeConfig.bodyHeight * .1),
          AppImage.asset(
            Assets.images.logoCirclure.path,
            height: SizeConfig.bodyHeight * .17,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .04),
          AppText(
            text: context.localizations.enterVerification,
            fontWeight: FontWeight.w600,
            maxLines: 1,
            textSize: 22,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          AppText.hint(
            text: context.localizations.verificationCode1,
            maxLines: 4,
            textSize: 14,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          AppText(
            text: widget.phoneNumber,
            maxLines: 4,
            textSize: 14,
            fontWeight: FontWeight.w400,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .06),
          Directionality(
            textDirection: TextDirection.ltr,
            child: PinCodeTextField(
              appContext: context,
              autoFocus: true,
              cursorColor: context.colorScheme.primary,
              keyboardType: TextInputType.number,
              length: 6,
              textStyle: const TextStyle(color: Colors.black),
              obscureText: false,
              animationType: AnimationType.scale,
              pinTheme: PinTheme(
                borderRadius: BorderRadius.circular(8),
                shape: PinCodeFieldShape.box,
                fieldHeight: 60,
                fieldWidth: 50,
                borderWidth: 1,
                inactiveColor: context.colorScheme.outline,
                activeFillColor: Colors.transparent,
                activeColor: context.colorScheme.primary,
                inactiveFillColor: context.colorScheme.inversePrimary,
                selectedColor: context.colorScheme.primary,
                selectedFillColor: Colors.transparent,
              ),
              animationDuration: const Duration(milliseconds: 300),
              onCompleted: (value) => setState(() => otpCode = value),
              enableActiveFill: true,
              onChanged: (String value) {},
            ),
          ),
          SizedBox(height: SizeConfig.bodyHeight * .06),
          BlocConsumer<OtpBloc, OtpState>(
            listener: (context, state) {
              if (state is VerifyOtpSuccessState) {
                if (state.userModel.isProfileCompleted == 1) {
                  _handleLogin(state.userModel);
                } else {
                  context.navigateTo(
                    UserRegisterScreen(phone: state.userModel.phone),
                  );
                }
              } else if (state is VerifyOtpFailureState) {
                AppConstant.showCustomSnakeBar(context, state.errorMsg, false);
              }
            },
            builder: (context, state) {
              final bloc = context.read<OtpBloc>();
              return CustomButton(
                isLoading: state is VerifyOtpLoadingState,
                isActive: otpCode.length == 6,
                text: context.localizations.confirm,
                press: () => bloc.add(
                  VerifyOtpCodeEvent(
                    userType: widget.userType,
                    phone: widget.phoneNumber,
                    otpCode: otpCode,
                  ),
                ),
              );
            },
          ),
          SizedBox(height: SizeConfig.bodyHeight * .06),
          OtpTimerDesign(phoneNumber: widget.phoneNumber),
        ],
      ).scrollable(),
    );
  }

  void _handleLogin(UserModel userModel) {
    if (userModel.tripModel != null) {
      TripModel tripModel = userModel.tripModel!;
      if (tripModel.driver != null) {
        if (tripModel.userSentRequestConfirmPayment == 1 &&
            tripModel.driverAcceptConfirmation == 1) {
          context.navigateToAndFinish(const MainLayout());
        } else {
          context.navigateToAndFinish(RequestTripScreen(tripModel: tripModel));
        }
      } else {
        if (tripModel.status == TripStatusEnum.waitingDriver) {
          context.navigateToAndFinish(RequestTripScreen(tripModel: tripModel));
        }
        context.navigateToAndFinish(const MainLayout());
      }
    } else {
      context.navigateToAndFinish(MainLayout());
    }
  }
}
