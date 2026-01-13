import 'dart:io';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/common/models/register_params.dart';
import 'package:taxito/features/user/auth/presentation/cubit/update/update_bloc.dart';
import 'package:taxito/features/user/location/presentation/widgets/choose_governorate_and_region.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/image_picker/media_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../../common/models/user_model_helper.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../../../captain/auth/presentation/pages/login_screen.dart';
import '../../../../../captain/auth/presentation/widgets/phone_field_widget.dart';
import '../../../../../captain/settings/settings_helper.dart';

class UpdateBody extends StatefulWidget {
  const UpdateBody({super.key});

  @override
  State<UpdateBody> createState() => _UpdateBodyState();
}

class _UpdateBodyState extends State<UpdateBody> {
  String? profilePath;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: screenPadding(),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: SizeConfig.bodyHeight * .04),
              Center(
                child: MediaFormField(
                  initialImage: UserDataService().getUserData()?.image,
                  height: SizeConfig.screenWidth * .33,
                  width: SizeConfig.screenWidth * .33,
                  onDataReceived: (File file) =>
                      setState(() => profilePath = file.path),
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .04),
              CustomTextFormField(
                name: "name",
                hintText: context.localizations.name,
                initialValue: UserDataService().getUserData()?.name,
                prefixIcon: AppImage.asset(Assets.icons.user),
                validator: FormBuilderValidators.required(
                  errorText: context.localizations.validation,
                ),
              ),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              const ChooseGovernorateAndRegion(),
              SizedBox(height: SizeConfig.bodyHeight * .02),
              PhoneFieldWidget(phone: UserDataService().getUserData()?.phone),
              SizedBox(height: SizeConfig.bodyHeight * .08),
              BlocConsumer<UpdateBloc, UpdateState>(
                listener: (context, state) {
                  if (state is UpdateUserDataSuccess) {
                    AppConstant.showCustomSnakeBar(context, state.msg, true);
                  }
                  if (state is UpdateUserDataFailure) {
                    AppConstant.showCustomSnakeBar(
                      context,
                      state.errorMsg,
                      false,
                    );
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    text: context.localizations.saveUpdates,
                    isLoading: state is UpdateUserDataLoading,
                    press: () {
                      if (!_formKey.currentState!.saveAndValidate()) {
                        return;
                      }
                      RegisterParams params = RegisterParams(
                        name: _formKey.fieldValue("name"),
                        phone: _formKey.fieldValue("phone"),
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
          ),
        ),
      ),
    );
  }
}
