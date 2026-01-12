import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/validitor_extention.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/core/services/location/location_manager.dart';
import 'package:taxito/core/services/location/location_permission_service.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/location/data/models/requests/location_params.dart';
import 'package:taxito/features/user/location/domain/entities/location_entity.dart';
import 'package:taxito/features/user/location/location_helper.dart';
import 'package:taxito/features/user/location/presentation/cubit/add_new_address/add_new_address_cubit.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../captain/app/data/models/generic_model.dart';
import '../../pages/pick_location_page.dart';
import '../choose_governorate_and_region.dart';

class AuthLocationBody extends StatefulWidget {
  const AuthLocationBody({super.key});

  @override
  State<AuthLocationBody> createState() => _AuthLocationBodyState();
}

class _AuthLocationBodyState extends State<AuthLocationBody> {
  SavedLocationParams? params;
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddNewAddressCubit, AddNewAddressState>(
      listener: (context, state) {
        if (state is AddNewAddressSuccess) {
          context.navigateToAndFinish(const MainLayout());
        } else if (state is AddNewAddressFailure) {
          AppConstant.showCustomSnakeBar(context, state.msg, false);
        }
      },
      builder: (context, state) {
        return Padding(
          padding: screenPadding(),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.bodyHeight * .05),
                AppImage.asset(
                  Assets.images.locationPicker.path,
                  width: SizeConfig.screenWidth * .3,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .06),
                AppText(
                  text: context.localizations.whereAreUNow,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  textSize: 22,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                AppText.hint(
                  text: context.localizations.whereAreUNow2,
                  maxLines: 6,
                  align: TextAlign.center,
                  textSize: 13,
                  fontWeight: FontWeight.w400,
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                const ChooseGovernorateAndRegion(),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                CustomTextFormField(
                  name: "notes",
                  maxLines: 6,
                  hintText: context.localizations.notes,
                  prefixIcon: AppImage.asset(Assets.icons.edit),
                  validator: FormBuilderValidators.required(
                    errorText: context.localizations.validation,
                  ),
                ),
                SizedBox(height: SizeConfig.bodyHeight * .04),
                CustomButton(
                  text: context.localizations.currentLocation,
                  isLoading: state is AddNewAddressLoading,
                  press: () async {
                    if (!_formKey.currentState!.saveAndValidate()) {
                      return;
                    }
                    params = params?.copyWith(
                      provinceId:
                          (_formKey.fieldValue("governorate") as GenericModel)
                              .id,
                      regionId:
                          (_formKey.fieldValue("region") as GenericModel).id,
                      notes: _formKey.fieldValue("notes"),
                    );

                    if (params != null) {
                      context.read<AddNewAddressCubit>().addNewAddress(
                        saved: params!,
                      );
                    }
                  },
                ),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                CustomButton(
                  text: context.localizations.selectAnotherLocation,
                  press: () => context.navigateTo(
                    const PickLocationScreen(),
                    callback: (data) {
                      if (!_formKey.currentState!.saveAndValidate()) {
                        return;
                      }

                      if (data != null) {
                        LocationEntity entity = data;
                        context.read<AddNewAddressCubit>().addNewAddress(
                          saved: SavedLocationParams(
                            lat: entity.lat,
                            lng: entity.lon,
                            provinceId:
                                (_formKey.fieldValue("governorate")
                                        as GenericModel)
                                    .id,
                            regionId:
                                (_formKey.fieldValue("region") as GenericModel)
                                    .id,
                            notes: _formKey.fieldValue("notes"),
                            address: entity.address.isEmpty
                                ? context
                                      .localizations
                                      .locationPickedSuccessFully
                                : entity.address,
                            isDefault: 1,
                          ),
                        );
                      }
                    },
                  ),
                  textColor: context.colorScheme.onSurface,
                  borderColor: context.colorScheme.onSurface,
                  backgroundColor: Colors.transparent,
                ),
              ],
            ).scrollable(),
          ),
        );
      },
    );
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      LocationHelper().showLocationLoadingDailog(context: context);
    });
    final response = await LocationPermissionService().requestPermissionAndLocation();

    if (response.status == LocationPermissionStatus.granted) {
      final data = await LocationManager.getMyAddress(latLng: response.location!);
      params = SavedLocationParams(
        lat: response.location!.latitude,
        isDefault: 1,
        lng: response.location!.longitude,
        address: data,
      );
      Navigator.pop(context);
      setState(() {});
    }
  }
}
