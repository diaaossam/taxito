import 'package:logger/logger.dart';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/features/common/models/user_model.dart';
import 'package:taxito/features/captain/auth/presentation/pages/driver_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:taxito/features/user/auth/presentation/pages/register_screen.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:taxito/features/vendor/main/presentation/pages/main_layout.dart';
import '../../../../../common/models/trip_model.dart';
import '../../../../../../core/enum/trip_status_enum.dart';
import '../../../../../../core/utils/app_constant.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../../../user/trip/presentation/pages/request_trip_screen.dart';
import '../../../../../vendor/auth/presentation/pages/supplier_register.dart';
import '../../../../delivery_main/presentation/pages/delivery_main_layout.dart';
import '../../../../driver_main/presentation/pages/driver_main_layout.dart';
import '../../cubit/otp/otp_bloc.dart';
import 'otp_counter.dart';

class OtpVerficationWidget extends StatefulWidget {
  final String phoneNumber;
  final bool isLogin;
  final UserType userType;

  const OtpVerficationWidget({
    super.key,
    required this.phoneNumber,
    required this.isLogin,
    required this.userType,
  });

  @override
  State<OtpVerficationWidget> createState() => _OtpVerficationWidgetState();
}

class _OtpVerficationWidgetState extends State<OtpVerficationWidget> {
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpBloc, OtpState>(
      listener: (context, state) {
        if (state is VerifyOtpSuccessState) {
          _handleLogin(state.data);
        } else if (state is VerifyOtpFailureState) {
          AppConstant.showCustomSnakeBar(context, state.errorMsg, false);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: screenPadding(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: SizeConfig.bodyHeight * .06),
              AppImage.asset(
                Assets.images.otp.path,
                height: SizeConfig.bodyHeight * .25,
                width: SizeConfig.bodyHeight * .3,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .12),
              AppText(
                text: "OTP",
                fontWeight: FontWeight.bold,
                maxLines: 1,
                textSize: 22,
                color: context.colorScheme.onSurface,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              AppText(
                text: context.localizations.verificationCode,
                maxLines: 2,
                textSize: 13,
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              Directionality(
                textDirection: TextDirection.ltr,
                child: AppText(
                  text: widget.phoneNumber,
                  maxLines: 1,
                  textSize: 15,
                  color: context.colorScheme.shadow,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .04),
              Directionality(
                textDirection: TextDirection.ltr,
                child: PinCodeTextField(
                  appContext: context,
                  autoFocus: true,
                  cursorColor: context.colorScheme.primary,
                  keyboardType: TextInputType.number,
                  length: 6,
                  textStyle: const TextStyle(color: Colors.white),
                  obscureText: false,
                  animationType: AnimationType.scale,
                  pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(20),
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 60,
                    fieldWidth: 50,
                    borderWidth: 1,
                    inactiveColor: context.colorScheme.primary,
                    activeFillColor: context.colorScheme.primary,
                    activeColor: context.colorScheme.primary,
                    inactiveFillColor: Colors.transparent,
                    selectedColor: context.colorScheme.primary,
                    selectedFillColor: Colors.transparent,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onChanged: (String value) => setState(() => otp = value),
                  onCompleted: (value) => context.read<OtpBloc>().add(
                    VerifyOtpCodeEvent(
                      userType: widget.userType,
                      phone: widget.phoneNumber,
                      otpCode: value,
                    ),
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .06),
              CustomButton(
                isActive: otp.length == 6,
                isLoading: state is VerifyOtpLoadingState,
                text: context.localizations.login,
                press: () => context.read<OtpBloc>().add(
                  VerifyOtpCodeEvent(
                    userType: UserType.driver,
                    phone: widget.phoneNumber,
                    otpCode: otp,
                  ),
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .04),
              OtpTimerDesign(
                userType: widget.userType,
                phoneNumber: widget.phoneNumber,
              ),
            ],
          ).scrollable(),
        );
      },
    );
  }

  void _handleNavigation(UserModel userModel) {
    if (widget.userType == UserType.supplier) {
      context.navigateToAndFinish(const SupplierMainLayout());
    } else if (widget.userType == UserType.user) {
      if (userModel.userTripModel != null) {
        var tripModel = userModel.userTripModel!;
        if (tripModel.driver != null) {
          if (tripModel.userSentRequestConfirmPayment == 1 && tripModel.driverAcceptConfirmation == 1) {
            context.navigateToAndFinish(const MainLayout());
          } else {
            context.navigateToAndFinish(
              RequestTripScreen(tripModel: tripModel),
            );
          }
        } else {
          if (tripModel.status == TripStatusEnum.waitingDriver) {
            context.navigateToAndFinish(
              RequestTripScreen(tripModel: tripModel),
            );
          }
          context.navigateToAndFinish(const MainLayout());
        }
      }
      else {
        context.navigateToAndFinish(MainLayout());
      }
    } else {
      if (userModel.driverType == "delivery_driver") {
        context.navigateToAndFinish(const DeliveryMainLayout());
      } else {
        if (userModel.captainTripModel != null) {
          TripModel? tripModel = userModel.captainTripModel;
          if (tripModel!.userSentRequestConfirmPayment == 1 &&
              tripModel.driverAcceptConfirmation == 1) {
            context.navigateToAndFinish(const DriverMainLayout());
          } else {
            context.navigateToAndFinish(DriverMainLayout(tripModel: tripModel));
          }
        } else {
          context.navigateToAndFinish(const DriverMainLayout());
        }
      }
    }
  }

  void _handleLogin(UserModel data) {
    if (data.isProfileCompleted == 1) {
      _handleNavigation(data);
    } else {
      if (widget.userType == UserType.driver ||
          widget.userType == UserType.delivery) {
        context.navigateToAndFinish(
          DriverRegisterScreen(isUpdate: false, phone: widget.phoneNumber),
        );
      } else if (widget.userType == UserType.supplier) {
        context.navigateToAndFinish(SupplierRegisterScreen(isUpdate: false));
      } else {
        context.navigateToAndFinish(
          UserRegisterScreen(phone: widget.phoneNumber),
        );
      }
    }
  }
}
