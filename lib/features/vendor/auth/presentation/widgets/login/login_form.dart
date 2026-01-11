import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../settings/presentation/widgets/copywrite_widget.dart';
import '../../cubit/login_cubit/login_cubit.dart';
import '../../pages/otp_verifcation_page.dart';
import '../phone_field_widget.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state is SendOtpError) {
          AppConstant.showCustomSnakeBar(context, state.msg, false);
        } else if (state is SendOtpSuccess) {
          context.navigateTo(OtpVerificationScreen(
            phoneNumber: state.phoneNumber,
            isLogin: true,
          ));
        }
      },
      builder: (context, state) {
        return FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const PhoneFieldWidget(),
              SizedBox(
                height: SizeConfig.bodyHeight * .04,
              ),
              CustomButton(
                  isLoading: state is SendOtpLoading,
                  text: context.localizations.sendCode,
                  press: () {
                    if (!_formKey.currentState!.saveAndValidate()) {
                      return;
                    }
                    context.read<LoginCubit>().sendOtp(
                        phone: _formKey.fieldValue("phone"));
                  }),
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),

              CopyWriteWidget(),
              SizedBox(
                height: SizeConfig.bodyHeight * .04,
              ),
            ],
          ),
        );
      },
    );
  }
}
