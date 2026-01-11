import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/features/auth/presentation/pages/supplier_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../../main/presentation/pages/main_layout.dart';
import '../../cubit/otp/otp_bloc.dart';
import 'otp_counter.dart';

class OtpVerficationWidget extends StatefulWidget {
  final String phoneNumber;
  final bool isLogin;

  const OtpVerficationWidget({
    super.key,
    required this.phoneNumber,
    required this.isLogin,
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
          if (state.data.isProfileCompleted == 1) {
            context.navigateToAndFinish(const SupplierMainLayout());
          } else {
            context.navigateTo(const RegisterScreen(
              isUpdate: false,
            ));
          }
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
                Assets.images.logoCirclure.path,
                height: SizeConfig.bodyHeight * .25,
                width: SizeConfig.bodyHeight * .3,
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .06,
              ),
              AppText(
                text: context.localizations.otpTitle,
                fontWeight: FontWeight.bold,
                maxLines: 1,
                textSize: 22,
                color: context.colorScheme.onSurface,
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
              AppText(
                text: context.localizations.verificationCode,
                maxLines: 2,
                textSize: 13,
                align: TextAlign.center,
                textHeight: 1.7,
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w400,
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
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .06),
              CustomButton(
                  isActive: otp.length == 6,
                  isLoading: state is VerifyOtpLoadingState,
                  text: context.localizations.verifyCode,
                  press: () => context.read<OtpBloc>().add(VerifyOtpCodeEvent(
                      phone: widget.phoneNumber, otpCode: otp))),
              SizedBox(height: SizeConfig.bodyHeight * .04),
              OtpTimerDesign(
                phoneNumber: widget.phoneNumber,
              ),
            ],
          ).scrollable(),
        );
      },
    );
  }
}
