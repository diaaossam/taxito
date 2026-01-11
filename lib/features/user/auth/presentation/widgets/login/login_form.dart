import 'package:aslol/core/enum/user_type.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/app_constant.dart';
import 'package:aslol/features/auth/data/models/request/login_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/validitor_extention.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/auth/presentation/cubit/login_cubit/login_cubit.dart';
import 'package:aslol/features/auth/presentation/widgets/phone_field_widget.dart';
import 'package:aslol/widgets/custom_button.dart';
import '../../../../settings/presentation/widgets/copywrite_widget.dart';
import '../../pages/otp_verifcation_page.dart';
import '../dont_have_account.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

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
            height: SizeConfig.bodyHeight * .06,
          ),
          BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginError) {
                AppConstant.showCustomSnakeBar(context, state.msg, false);
              } else if (state is LoginSuccess) {
                context.navigateTo(OtpVerificationScreen(
                  userType: state.userType,
                  phoneNumber: "${_formKey.fieldValue("phone")}",
                ));
              }
            },
            builder: (context, state) {
              return CustomButton(
                  isLoading: state is LoginLoading,
                  text: context.localizations.login,
                  press: () {
                    if (!_formKey.currentState!.saveAndValidate()) {
                      return;
                    }
                    context.read<LoginCubit>().login(
                        params: LoginParams(
                            phone: _formKey.fieldValue("phone"),
                            userType: UserType.user));
                  });
            },
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .06,
          ),
          CopyWriteWidget(),
          //const DontHaveAccountWidget(),
          SizedBox(
            height: SizeConfig.bodyHeight * .04,
          ),
        ],
      ),
    );
  }
}
