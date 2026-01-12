import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/data/models/user_model_helper.dart';
import 'package:taxito/features/captain/auth/presentation/cubit/complete_register/complete_register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../../../../core/utils/app_size.dart';
import '../../../../../../../../widgets/custom_button.dart';
import '../../../../../../../../widgets/custom_text_form_field.dart';
import 'package:taxito/core/data/models/user_model.dart';
import '../../../id_photo_picker.dart';
import 'complete_register_button.dart';

class CompleteRegisterPage2 extends StatefulWidget {
  final bool isUpdate;
  final UserModel? userModel;

  const CompleteRegisterPage2(
      {super.key, this.userModel, required this.isUpdate});

  @override
  State<CompleteRegisterPage2> createState() => _CompleteRegisterPage2State();
}

class _CompleteRegisterPage2State extends State<CompleteRegisterPage2> {
  final _formKey = GlobalKey<FormBuilderState>();
  final focusNode = FocusNode();

  @override
  void initState() {
    if (widget.userModel == null) {
      focusNode.requestFocus();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: screenPadding(),
            child: Column(
              children: <Widget>[
                20.verticalSpace,
                CustomTextFormField(
                  name: "car_plate",
                  initialValue: UserDataService().getUserData()?.carPlateNumber,
                  title: context.localizations.plateNumbers,
                  focusNode: focusNode,
                  hintText: context.localizations.numberChar,
                  validator: FormBuilderValidators.required(
                      errorText: context.localizations.validation),
                ),
                20.verticalSpace,
                IdPhotoPicker(
                  name: "frontDrivingLicence",
                  callback: (p0) => focusNode.unfocus(),
                  height: SizeConfig.bodyHeight * .25,
                  initialImage:
                      UserDataService().getUserData()?.driverLicenseFrontImage,
                  title: context.localizations.frontDrivingLicence,
                  validator: UserDataService().getUserData() == null
                      ? FormBuilderValidators.required(
                          errorText: context.localizations.validation)
                      : null,
                ),
                20.verticalSpace,
                IdPhotoPicker(
                  name: "backDrivingLicence",
                  callback: (p0) => focusNode.unfocus(),
                  initialImage:
                      UserDataService().getUserData()?.driverLicenseBackImage,
                  height: SizeConfig.bodyHeight * .25,
                  title: context.localizations.backDrivingLicence,
                  validator: UserDataService().getUserData() == null
                      ? FormBuilderValidators.required(
                          errorText: context.localizations.validation)
                      : null,
                ),
                20.verticalSpace,
                if (widget.isUpdate) ...[
                  BlocBuilder<CompleteRegisterBloc, CompleteRegisterState>(
                    builder: (context, state) {
                      return CustomButton(
                          text: context.localizations.next,
                          backgroundColor: Colors.transparent,
                          textColor: context.colorScheme.primary,
                          press: () {
                            context
                                .read<CompleteRegisterBloc>()
                                .add(OnPageChangedEvent(index: 2));
                          });
                    },
                  ),
                  10.verticalSpace,
                ],
                CompleteRegisterButton(
                  formKey: _formKey,
                  isUpdate: widget.isUpdate,
                ),
                if (UserDataService().getUserData() != null) 60.verticalSpace,
                40.verticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
