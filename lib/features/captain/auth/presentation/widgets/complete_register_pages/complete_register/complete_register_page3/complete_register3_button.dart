import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import '../../../../../../../../../core/utils/app_constant.dart';
import '../../../../../../../../core/utils/app_size.dart';
import '../../../../../../../../widgets/custom_button.dart';
import '../../../../../../../common/models/user_model_helper.dart';
import 'package:taxito/features/common/models/register_params.dart';
import '../../../../cubit/complete_register/complete_register_bloc.dart';
import '../../../../pages/waiting_for_review_screen.dart';

class CompleteRegister3Button extends StatelessWidget {
  final GlobalKey<FormBuilderState> formKey;
  final List<String> carImages;
  final bool isUpdate;

  const CompleteRegister3Button(
      {super.key,
      required this.formKey,
      required this.carImages,
      required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteRegisterBloc, CompleteRegisterState>(
      listener: (context, state) {
        if (state is RegisterUserSuccess) {
          if(!isUpdate){
            context.navigateToAndFinish(const WaitingForReviewScreen());
          }
        } else if (state is RegisterUserFailure) {
          AppConstant.showCustomSnakeBar(context, state.errorMsg, false);
        }
      },
      builder: (context, state) {
        final bloc = context.read<CompleteRegisterBloc>();
        return Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.screenWidth * .04,
            right: SizeConfig.screenWidth * .04,
            bottom: SizeConfig.screenWidth * .04,
          ),
          child: CustomButton(
              isLoading: state is RegisterUserLoading,
              text: isUpdate ? context.localizations.update :context.localizations.next,
              press: () {
                if (!formKey.currentState!.saveAndValidate()) return;
                if (carImages.length < 5 && !isUpdate) {
                  AppConstant.showCustomSnakeBar(
                      context, context.localizations.vehicleImageHint, false);
                  return;
                }
                RegisterParams registerParams = bloc.registerParams.copyWith(
                  carImages: carImages,
                  name: UserDataService().getUserData()?.name,
                  firstName: UserDataService().getUserData()?.firstName,
                  lastName: UserDataService().getUserData()?.lastName,
                  governorateId: UserDataService().getUserData()?.province?.id,
                  carPlateNumber: UserDataService().getUserData()?.carPlateNumber,
                  frontInsurancePhoto: formKey.fieldValue("frontInsurancePhoto"),
                  backInsurancePhoto: formKey.fieldValue("backInsurancePhoto"),
                );
                context.read<CompleteRegisterBloc>().add(
                    CompleteRegisterSuccessEvent(
                        registerParams: registerParams));
              }),
        );
      },
    );
  }
}
