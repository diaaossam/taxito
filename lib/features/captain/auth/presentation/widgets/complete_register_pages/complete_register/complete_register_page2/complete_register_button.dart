import 'dart:io';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:taxito/features/captain/auth/data/models/response/user_model_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../../../../../core/utils/app_constant.dart';
import '../../../../../../../../widgets/custom_button.dart';
import '../../../../../domain/entity/register_params.dart';
import '../../../../cubit/complete_register/complete_register_bloc.dart';

class CompleteRegisterButton extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final bool isUpdate;

  const CompleteRegisterButton(
      {super.key, required this.formKey, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteRegisterBloc, CompleteRegisterState>(
      listener: (context, state) {
        if (state is RegisterUserSuccess) {
         // Navigator.pop(context);
        } else if (state is RegisterUserFailure) {
          AppConstant.showCustomSnakeBar(context, state.errorMsg, false);
        }
      },
      builder: (context, state) {
        final bloc = context.read<CompleteRegisterBloc>();
        return CustomButton(
          isLoading: state is RegisterUserLoading,
            text: isUpdate?context.localizations.update :context.localizations.next,
            press: () {
              if (!formKey.currentState!.saveAndValidate()) return;
              final front = formKey.fieldValue("frontDrivingLicence");
              final back = formKey.fieldValue("backDrivingLicence");
              RegisterParams registerParams = bloc.registerParams.copyWith(
                name: UserDataService().getUserData()?.name,
                firstName: UserDataService().getUserData()?.firstName,
                lastName: UserDataService().getUserData()?.lastName,
                governorateId: UserDataService().getUserData()?.province?.id,
                carPlateNumber: "${formKey.fieldValue('car_plate')}",
                frontDriverLicense: front is File
                    ? formKey.fieldValue("frontDrivingLicence").path
                    : formKey.fieldValue("frontDrivingLicence"),
                backDriverLicense: back is File
                    ? formKey.fieldValue("backDrivingLicence").path
                    : formKey.fieldValue("backDrivingLicence"),
              );

              if(isUpdate){
                context.read<CompleteRegisterBloc>().add(
                    CompleteRegisterSuccessEvent(
                        registerParams: registerParams,));
              }else{
                context.read<CompleteRegisterBloc>().add(
                    UpdateRegisterParamsEvent(
                        registerParams: registerParams, nextStep: 2));
              }

            });
      },
    );
  }
}
