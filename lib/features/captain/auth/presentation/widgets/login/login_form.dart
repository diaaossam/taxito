import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:taxito/features/captain/settings/presentation/widgets/copywrite_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:taxito/features/vendor/product/data/models/response/review_model.dart';

import '../../../../../../core/enum/user_type.dart';
import '../../../../../../core/utils/app_constant.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../cubit/login_cubit/login_cubit.dart';
import '../../pages/otp_verifcation_page.dart';
import '../phone_field_widget.dart';

class LoginForm extends StatefulWidget {
  final UserType userType;

  LoginForm({super.key, required this.userType});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late UserType userType;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    userType = widget.userType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const PhoneFieldWidget(),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          AppText(
            text: context.localizations.phoneBody,
            maxLines: 2,
            textSize: 10,
            fontWeight: FontWeight.w400,
            color: context.colorScheme.shadow,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .04),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is SendOtpError) {
                AppConstant.showCustomSnakeBar(context, state.msg, false);
              } else if (state is SendOtpSuccess) {
                context.navigateTo(
                  OtpVerificationScreen(
                    userType: userType,
                    phoneNumber: state.phoneNumber,
                    isLogin: true,
                  ),
                );
              }
            },
            builder: (context, state) {
              return CustomButton(
                isLoading: state is SendOtpLoading,
                text: context.localizations.login,
                backgroundColor: Colors.transparent,
                textColor: context.colorScheme.primary,
                press: () {
                  if (!_formKey.currentState!.saveAndValidate()) {
                    return;
                  }
                  context.read<LoginCubit>().sendOtp(
                    userType: userType,
                    phone: _formKey.fieldValue("phone"),
                  );
                },
              );
            },
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          if (userType == UserType.user) ...[
            CustomButton(
              text: context.localizations.loginAsGuest,
              press: () {
                context.navigateToAndFinish(MainLayout());
              },
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
          ],

          const CopyWriteWidget(),
          SizedBox(height: SizeConfig.bodyHeight * .15),
          if(userType == UserType.user)...[
            TextButton(
              onPressed: () {
                setState(() => userType = UserType.supplier);
              },
              child: Center(
                child: AppText(
                  text: context.localizations.loginAsSupplier,
                  fontWeight: FontWeight.w600,
                  textSize: 14,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() => userType = UserType.driver);
              },
              child: Center(
                child: AppText(
                  text: context.localizations.loginAsTaxi,
                  fontWeight: FontWeight.w600,
                  textSize: 14,
                  textDecoration: TextDecoration.underline,
                ),
              ),
            ),
          ]

        ],
      ),
    );
  }
}
