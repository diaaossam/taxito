import 'dart:io';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/features/common/models/user_model_helper.dart';
import 'package:taxito/features/captain/auth/presentation/widgets/id_photo_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/sliver_padding.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import '../../../../../../driver_account/presentation/widgets/driver_account_profile_image.dart';
import 'package:taxito/features/common/models/register_params.dart';
import '../../../../cubit/complete_register/complete_register_bloc.dart';
import '../../../governorate_widget.dart';
import '../../../phone_field_widget.dart';

class CompleteRegisterPage1 extends StatefulWidget {
  final bool isUpdate;

  const CompleteRegisterPage1({super.key, required this.isUpdate});

  @override
  State<CompleteRegisterPage1> createState() => _CompleteRegisterPage1State();
}

class _CompleteRegisterPage1State extends State<CompleteRegisterPage1> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? profilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            DriverAccountProfileImage(
              onDataReceived: (p0) => setState(() => profilePath = p0.path),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    name: "firstName",
                    title: context.localizations.firstName,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[a-zA-Z\u0621-\u064A\s]', unicode: true),
                      ),
                      LengthLimitingTextInputFormatter(20),
                    ],
                    initialValue: UserDataService().getUserData()?.firstName,
                    hintText: context.localizations.firstName,
                    validator: FormBuilderValidators.required(
                      errorText: context.localizations.validation,
                    ),
                  ),
                ),
                20.horizontalSpace,
                Expanded(
                  child: CustomTextFormField(
                    name: "lastName",
                    initialValue: UserDataService().getUserData()?.lastName,
                    title: context.localizations.secondName,
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
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            PhoneFieldWidget(
              readOnly: true,
              phone: UserDataService().getUserData()?.phone,
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            CustomTextFormField(
              name: "email",
              initialValue: UserDataService().getUserData()?.email,
              title: context.localizations.emailAddress,
              hintText: context.localizations.emailAddress,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            const GovernorateWidget(showLabel: true).toSliverPadding(),
            20.verticalSpace.toSliver,
            IdPhotoPicker(
              name: "frontId",
              initialImage: UserDataService().getUserData()?.idFrontImage,
              height: SizeConfig.bodyHeight * .25,
              title: context.localizations.frontPhoto,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            IdPhotoPicker(
              name: "backId",
              initialImage: UserDataService().getUserData()?.idBackImage,
              height: SizeConfig.bodyHeight * .25,
              title: context.localizations.backPhoto,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
          ],
        ),
      ),
      bottomNavigationBar:
          BlocBuilder<CompleteRegisterBloc, CompleteRegisterState>(
            builder: (context, state) {
              final bloc = context.read<CompleteRegisterBloc>();
              return Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * .04,
                  right: SizeConfig.screenWidth * .04,
                  bottom: SizeConfig.screenWidth * .04,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.isUpdate) ...[
                      CustomButton(
                        text: context.localizations.next,
                        backgroundColor: Colors.transparent,
                        textColor: context.colorScheme.primary,
                        press: () {
                          bloc.add(OnPageChangedEvent(index: 1));
                        },
                      ),
                      10.verticalSpace,
                    ],
                    BlocConsumer<CompleteRegisterBloc, CompleteRegisterState>(
                      listener: (context, state) {
                        if (state is RegisterUserSuccess) {
                          Navigator.pop(context);
                        } else if (state is RegisterUserFailure) {
                          AppConstant.showCustomSnakeBar(
                            context,
                            state.errorMsg,
                            false,
                          );
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                          isLoading: state is RegisterUserLoading,
                          text: widget.isUpdate
                              ? context.localizations.update
                              : context.localizations.next,
                          press: () {
                            if (!_formKey.currentState!.saveAndValidate())
                              return;
                            if (profilePath == null && !widget.isUpdate) {
                              AppConstant.showCustomSnakeBar(
                                context,
                                context.localizations.profileImageValidation,
                                false,
                              );
                              return;
                            }
                            final frontIdImage = _formKey.fieldValue("frontId");
                            final backIdImage = _formKey.fieldValue("backId");
                            RegisterParams registerParams = bloc.registerParams
                                .copyWith(userTypeEnum: UserType.driver,
                                  carPlateNumber: UserDataService()
                                      .getUserData()
                                      ?.carPlateNumber,
                                  phone: _formKey.fieldValue("phone"),
                                  firstName: _formKey.fieldValue("firstName"),
                                  lastName: _formKey.fieldValue("lastName"),
                                  email: _formKey.fieldValue("email"),
                                  governorateId: _formKey.fieldValue(
                                    "governorate",
                                  ),
                                  profileImage: profilePath,
                                  frontIdImage: frontIdImage is File
                                      ? _formKey.fieldValue("frontId").path
                                      : _formKey.fieldValue("frontId"),
                                  backIdImage: backIdImage is File
                                      ? _formKey.fieldValue("backId").path
                                      : _formKey.fieldValue("backId"),
                                );

                            if (widget.isUpdate) {
                              context.read<CompleteRegisterBloc>().add(
                                CompleteRegisterSuccessEvent(
                                  registerParams: registerParams,
                                ),
                              );
                            } else {
                              context.read<CompleteRegisterBloc>().add(
                                UpdateRegisterParamsEvent(
                                  nextStep: 1,
                                  registerParams: registerParams,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
    );
  }
}
