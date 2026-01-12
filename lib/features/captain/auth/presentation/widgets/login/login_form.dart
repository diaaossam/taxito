import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:taxito/features/captain/settings/presentation/widgets/copywrite_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../../../core/enum/user_type.dart';
import '../../../../../../core/utils/app_constant.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../cubit/login_cubit/login_cubit.dart';
import '../../pages/otp_verifcation_page.dart';
import '../phone_field_widget.dart';

class LoginForm extends StatelessWidget {
  final UserType userType;

  LoginForm({super.key, required this.userType});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const PhoneFieldWidget(),
          SizedBox(
            height: SizeConfig.bodyHeight * .02,
          ),
          AppText(
            text: context.localizations.phoneBody,
            maxLines: 2,
            textSize: 10,
            fontWeight: FontWeight.w400,
            color: context.colorScheme.shadow,
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .2,
          ),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is SendOtpError) {
                AppConstant.showCustomSnakeBar(context, state.msg, false);
              } else if (state is SendOtpSuccess) {
                context.navigateTo(OtpVerificationScreen(
                  userType: userType,
                  phoneNumber: state.phoneNumber,
                  isLogin: true,
                ));
              }
            },
            builder: (context, state) {
              return CustomButton(
                  isLoading: state is SendOtpLoading,
                  text: context.localizations.login,
                  press: () {
                    if (!_formKey.currentState!.saveAndValidate()) {
                      return;
                    }
                    context.read<LoginCubit>().sendOtp(
                        userType: userType,
                        phone: _formKey.fieldValue("phone"));
                  });
            },
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .04,
          ),
          const CopyWriteWidget(),
          SizedBox(
            height: SizeConfig.bodyHeight * .02,
          ),
        ],
      ),
    );
  }
}
