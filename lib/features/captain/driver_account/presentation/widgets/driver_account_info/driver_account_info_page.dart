import 'dart:io';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../../core/utils/app_constant.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../common/models/user_model_helper.dart';
import 'package:taxito/features/common/models/register_params.dart';
import '../../../../../user/auth/presentation/cubit/update/update_bloc.dart';
import '../../../../auth/presentation/widgets/governorate_widget.dart';
import '../../../../auth/presentation/widgets/id_photo_picker.dart';
import '../../../../auth/presentation/widgets/phone_field_widget.dart';

class DriverAccountInfoPage extends StatefulWidget {
  const DriverAccountInfoPage({super.key});

  @override
  State<DriverAccountInfoPage> createState() => _DriverAccountInfoPageState();
}

class _DriverAccountInfoPageState extends State<DriverAccountInfoPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateBloc, UpdateState>(
      listener: (context, state) {
        if (state is UpdateUserDataFailure) {
          AppConstant.showCustomSnakeBar(context, state.errorMsg, false);
        } else if (state is UpdateUserDataSuccess) {
          AppConstant.showCustomSnakeBar(
            context,
            context.localizations.userUpdatedSuccessfully,
            true,
          );
        }
      },
      builder: (context, state) {
        return FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                30.verticalSpace,
                Padding(
                  padding: screenPadding(),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          name: "firstName",
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\u0621-\u064A\s]', unicode: true),
                            ),
                            LengthLimitingTextInputFormatter(20),
                          ],
                          initialValue: UserDataService()
                              .getUserData()
                              ?.firstName,
                          hintText: context.localizations.firstName,
                          validator: FormBuilderValidators.required(
                            errorText: context.localizations.validation,
                          ),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: CustomTextFormField(
                          name: "lastName",
                          initialValue: UserDataService()
                              .getUserData()
                              ?.lastName,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'[a-zA-Z\u0621-\u064A\s]', unicode: true),
                            ),
                            LengthLimitingTextInputFormatter(20),
                          ],
                          hintText: context.localizations.secondName,
                          validator: FormBuilderValidators.required(
                            errorText: context.localizations.validation,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: screenPadding(),
                  child: PhoneFieldWidget(
                    isWithTitle: false,
                    phone: UserDataService().getUserData()?.phone,
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: screenPadding(),
                  child: const GovernorateWidget(showLabel: false),
                ),
                20.verticalSpace,
                Padding(
                  padding: screenPadding(),
                  child: IdPhotoPicker(
                    name: "frontId",
                    initialImage: UserDataService().getUserData()?.idBackImage,
                    height: SizeConfig.bodyHeight * .25,
                    title: context.localizations.frontPhoto,
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: screenPadding(),
                  child: IdPhotoPicker(
                    name: "backId",
                    initialImage: UserDataService().getUserData()?.idBackImage,
                    height: SizeConfig.bodyHeight * .25,
                    title: context.localizations.frontPhoto,
                  ),
                ),
                20.verticalSpace,
                Padding(
                  padding: screenPadding(),
                  child: CustomButton(
                    text: context.localizations.update,
                    isLoading: state is UpdateUserDataLoading,
                    press: () {
                      if (!_formKey.currentState!.saveAndValidate()) return;
                      File? frontIdImage = _formKey.fieldValue("frontId");
                      File? backIdImage = _formKey.fieldValue("backId");
                      RegisterParams registerParams = RegisterParams(
                        name:
                            "${_formKey.fieldValue('firstName')} ${_formKey.fieldValue('lastName')}",
                        phone: _formKey.fieldValue("phone"),
                        firstName: _formKey.fieldValue("firstName"),
                        lastName: _formKey.fieldValue("lastName"),
                        governorateId: _formKey.fieldValue("governorate"),
                        frontIdImage: frontIdImage?.path,
                        backIdImage: backIdImage?.path,
                      );
                      context.read<UpdateBloc>().add(
                        UpdateUserDataEvent(params: registerParams),
                      );
                    },
                  ),
                ),
                100.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }
}
