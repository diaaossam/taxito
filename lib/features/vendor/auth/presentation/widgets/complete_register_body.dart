import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../../core/data/models/user_model_helper.dart';
import '../../../../../core/enum/user_type.dart';
import '../../../../../core/extensions/app_localizations_extension.dart';
import '../../../../../core/extensions/navigation.dart';
import '../../../../../core/extensions/sliver_padding.dart';
import '../../../../../core/extensions/validitor_extention.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_multi_select.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../location/data/models/location_entity.dart';
import '../../../main/presentation/pages/main_layout.dart';
import 'package:taxito/core/data/models/register_params.dart';
import '../cubit/complete_register/complete_register_bloc.dart';
import 'driver_account_profile_image.dart';
import 'governorate_widget.dart';
import 'id_photo_picker.dart';

class RegisterBody extends StatefulWidget {
  final bool isUpdate;

  const RegisterBody({super.key, required this.isUpdate});

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? profilePath;
  String? coverPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            20.verticalSpace.toSliver,
            DriverAccountProfileImage(
              onCoverReceived: (p0) => setState(() => coverPath = p0.path),
              onProfileReceived: (p0) => setState(() => profilePath = p0.path),
              initialCover:
                  coverPath ?? UserDataService().getUserData()?.coverImage,
              initialImage:
                  profilePath ?? UserDataService().getUserData()?.profileImage,
            ).toSliverPadding(),
            CustomTextFormField(
              name: "firstName",
              title: context.localizations.commercialName,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-Z\u0621-\u064A\s]', unicode: true),
                ),
                LengthLimitingTextInputFormatter(40),
              ],
              initialValue: UserDataService().getUserData()?.name,
              hintText: context.localizations.placeName,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            BlocBuilder<CompleteRegisterBloc, CompleteRegisterState>(
              builder: (context, state) {
                final bloc = context.read<CompleteRegisterBloc>();
                return FormBuilderField<List<int>>(
                  name: "supplierCategories",
                  initialValue: UserDataService()
                      .getUserData()
                      ?.supplierCategories
                      ?.map((e) => e.id!)
                      .toList(),
                  builder: (FormFieldState<List<int>?> field) {
                    return MultiSelectDropdown(
                      label: context.localizations.activityType,
                      items: bloc.list,
                      initialSelectedItems: UserDataService()
                          .getUserData()
                          ?.supplierCategories
                          ?.map((e) => e)
                          .toList(),
                      onChanged: (selectedItems) {
                        field.didChange(
                          selectedItems.map((e) => e.id!).toList(),
                        );
                      },
                    );
                  },
                );
              },
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
            CustomTextFormField(
              name: "prepare",
              keyboardType: TextInputType.number,
              title: context.localizations.foodPrepare,
              hintText: context.localizations.foodPrepareHint,
              initialValue: UserDataService().getUserData()?.preparationTime,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            CustomTextFormField(
              keyboardType: TextInputType.number,
              name: "delivery",
              title: context.localizations.foodDelivery,
              initialValue: UserDataService().getUserData()?.deliveryTime,
              hintText: context.localizations.foodDeliveryHint,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
            IdPhotoPicker(
              name: "frontId",
              initialImage: UserDataService()
                  .getUserData()
                  ?.commercialRegistration,
              height: SizeConfig.bodyHeight * .25,
              title: context.localizations.commericalImage,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
            ).toSliverPadding(),
            20.verticalSpace.toSliver,
          ],
        ),
      ),
      bottomNavigationBar:
          BlocConsumer<CompleteRegisterBloc, CompleteRegisterState>(
            listener: (context, state) {
              if (state is RegisterUserSuccess) {
                context.navigateToAndFinish(const SupplierMainLayout());
              } else if (state is RegisterUserFailure) {
                AppConstant.showCustomSnakeBar(context, state.errorMsg, false);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.only(
                  left: SizeConfig.screenWidth * .04,
                  right: SizeConfig.screenWidth * .04,
                  bottom: SizeConfig.screenWidth * .04,
                ),
                child: CustomButton(
                  text: widget.isUpdate
                      ? context.localizations.update
                      : context.localizations.createNewAccount,
                  isLoading: state is RegisterUserLoading,
                  press: () {
                    if (!_formKey.currentState!.saveAndValidate()) return;
                    if (profilePath == null && !widget.isUpdate) {
                      AppConstant.showCustomSnakeBar(
                        context,
                        context.localizations.profileImageValidation,
                        false,
                      );
                      return;
                    }

                    final LocationEntity locationEntity = _formKey.fieldValue(
                      "location",
                    );

                    final formValues = _formKey.currentState!.value;
                    final firstName = formValues['firstName'] as String?;
                    final email = formValues['email'] as String?;
                    final governorateId = formValues['governorate'] as int?;
                    final regionId = formValues['region'] as int?;
                    final prepareTime = formValues['prepare'] as String?;
                    final deliveryTime = formValues['delivery'] as String?;
                    final frontIdImage = formValues['frontId'] as String?;
                    final selectedCategories =
                        formValues['supplierCategories'] as List<int>?;

                    RegisterParams registerParams = RegisterParams(
                      name: firstName,
                      email: email,
                      provinceId: governorateId?.toString(),
                      foodPreparationTime: prepareTime,
                      deliveryTime: deliveryTime,
                      commercialRegistration: frontIdImage,
                      profileImage: profilePath,
                      coverImage: coverPath,
                      supplierCategories: selectedCategories,
                      lat: locationEntity.lat,
                      lon: locationEntity.lon,
                      address: locationEntity.address,
                      regionId: regionId.toString(),
                      userTypeEnum: UserType.supplier,
                    );

                    context.read<CompleteRegisterBloc>().add(
                      UpdateRegisterParamsEvent(registerParams: registerParams),
                    );
                  },
                ),
              );
            },
          ),
    );
  }
}
