import 'dart:io';
import 'package:taxito/core/enum/gender.dart';
import 'package:taxito/core/enum/user_type.dart' hide usersType;
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/widgets/app_drop_down.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:taxito/widgets/image_picker/media_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../../../core/data/models/user_model_helper.dart';
import '../../../../../../core/enum/login_user_type.dart';
import '../../../../../captain/auth/presentation/pages/login_screen.dart';
import '../../../../../captain/auth/presentation/widgets/phone_field_widget.dart';
import '../../../../../captain/settings/settings_helper.dart';
import '../../../../location/presentation/pages/auth_location_screen.dart';
import 'package:taxito/core/data/models/register_params.dart';
import '../../cubit/update/update_bloc.dart';
import '../already_have_account.dart';

class RegisterBody extends StatefulWidget {
  final String? phone;

  const RegisterBody({super.key, this.phone});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? profilePath;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate =
        UserDataService().getUserData()?.isProfileCompleted == 1;
    return Padding(
      padding: screenPadding(),
      child: FormBuilder(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppText(
                  text: isUpdate
                      ? context.localizations.updateProfileData
                      : context.localizations.loginTitle,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  textSize: 22,
                ),
                5.horizontalSpace,
                if (!isUpdate)
                  AppText(
                    text: context.localizations.loginTitle2,
                    fontWeight: FontWeight.w600,
                    color: context.colorScheme.primary,
                    textSize: 22,
                  ),
              ],
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            if (!isUpdate)
              AppText.hint(
                text: context.localizations.registerBody,
                maxLines: 6,
                textSize: 13,
                fontWeight: FontWeight.w400,
              ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            Center(
              child: MediaFormField(
                height: SizeConfig.screenWidth * .33,
                width: SizeConfig.screenWidth * .33,
                initialImage: UserDataService().getUserData()?.profileImage,
                onDataReceived: (File file) =>
                    setState(() => profilePath = file.path),
              ),
            ),
            SizedBox(height: SizeConfig.bodyHeight * .04),
            CustomTextFormField(
              name: "name",
              initialValue: UserDataService().getUserData()?.name,
              hintText: context.localizations.name,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            PhoneFieldWidget(
              phone: widget.phone ?? UserDataService().getUserData()?.phone,
              readOnly:
                  widget.phone == null &&
                  UserDataService().getUserData()?.phone == null,
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            CustomTextFormField(
              name: "email",
              initialValue: UserDataService().getUserData()?.email,
              hintText:
                  "${context.localizations.emailAddress} ${context.localizations.optional}",
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            AppDropDown(
              name: 'gender',
              initialValue: UserDataService().getUserData()?.gender,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
              hint: context.localizations.gender,
              label: context.localizations.gender,
              items: genders
                  .map<DropdownMenuItem>(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: AppText(
                        text: e == Gender.male
                            ? context.localizations.male
                            : context.localizations.female,
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            AppDropDown(
              name: 'student',
              hint: context.localizations.studentOrEmployee,
              label: context.localizations.studentOrEmployee,
              initialValue:
                  UserDataService().getUserData()?.jobTitle == "student"
                  ? LoginUserType.student
                  : LoginUserType.employee,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
              items: usersType
                  .map<DropdownMenuItem>(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: AppText(
                        text: e == LoginUserType.employee
                            ? context.localizations.employee
                            : context.localizations.student,
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            BlocConsumer<UpdateBloc, UpdateState>(
              listener: (context, state) {
                if (state is UpdateUserDataFailure) {
                  AppConstant.showCustomSnakeBar(
                    context,
                    state.errorMsg,
                    false,
                  );
                }
                if (state is UpdateUserDataSuccess) {
                  if (isUpdate) {
                    Navigator.pop(context);

                    AppConstant.showCustomSnakeBar(context, state.msg, true);
                  } else {
                    context.navigateTo(const AuthLocationScreen());
                  }
                }
              },
              builder: (context, state) {
                return CustomButton(
                  isLoading: state is UpdateUserDataLoading,
                  text: isUpdate
                      ? context.localizations.edit
                      : context.localizations.createNewAccount,
                  press: () {
                    if (!_formKey.currentState!.saveAndValidate()) {
                      return;
                    }
                    if (profilePath == null && !isUpdate) {
                      AppConstant.showToast(
                        msg: context.localizations.noImageFound,
                        gravity: ToastGravity.TOP,
                      );
                      return;
                    }
                    RegisterParams params = RegisterParams(
                      name: _formKey.fieldValue("name"),
                      phone: widget.phone ?? _formKey.fieldValue("phone"),
                      email: _formKey.fieldValue("email"),
                      gender: _formKey.fieldValue("gender").name,
                      jobTitle: _formKey.fieldValue("student").name,
                      imagePath: profilePath,
                    );
                    context.read<UpdateBloc>().add(
                      UpdateUserDataEvent(params: params),
                    );
                  },
                );
              },
            ),
            SizedBox(height: SizeConfig.bodyHeight * .04),
            if (UserDataService().getUserData()?.isProfileCompleted == 0)
              const AlreadyHaveAccountWidget()
            else
              BlocConsumer<UpdateBloc, UpdateState>(
                listener: (context, state) {
                  if (state is DeleteUserDataFailure) {
                    AppConstant.showCustomSnakeBar(
                      context,
                      state.errorMsg,
                      false,
                    );
                  } else if (state is DeleteUserDataSuccess) {
                    context.navigateToAndFinish(
                      const LoginScreen(userType: UserType.user),
                    );
                  }
                },
                builder: (context, state) {
                  return InkWell(
                    onTap: () => SettingsHelper().showAppDialog(
                      context: context,
                      isAccept: (value) {
                        if (value) {
                          context.read<UpdateBloc>().add(DeleteUserDataEvent());
                        }
                      },
                      title: context.localizations.deleteAccountBody,
                    ),
                    child: AppText(
                      text: context.localizations.deleteAccount,
                      color: context.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
          ],
        ).scrollable(),
      ),
    );
  }
}
