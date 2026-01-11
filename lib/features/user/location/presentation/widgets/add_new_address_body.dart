import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/validitor_extention.dart';
import 'package:aslol/core/extensions/widget_ext.dart';
import 'package:aslol/core/utils/app_constant.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/auth/data/models/response/user_model_helper.dart';
import 'package:aslol/features/auth/presentation/widgets/phone_field_widget.dart';
import 'package:aslol/features/location/data/models/requests/location_params.dart';
import 'package:aslol/features/location/data/models/response/my_address.dart';
import 'package:aslol/features/location/domain/entities/location_entity.dart';
import 'package:aslol/features/location/presentation/cubit/add_new_address/add_new_address_cubit.dart';
import 'package:aslol/features/location/presentation/cubit/location_picker/location_picker_cubit.dart';
import 'package:aslol/features/location/presentation/widgets/choose_governorate_and_region.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/custom_text_form_field.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'add_location_map.dart';

class AddNewAddressBody extends StatefulWidget {
  final MyAddress? address;

  const AddNewAddressBody({super.key, this.address});

  @override
  State<AddNewAddressBody> createState() => _AddNewAddressBodyState();
}

class _AddNewAddressBodyState extends State<AddNewAddressBody> {
  final _formKey = GlobalKey<FormBuilderState>();
  LocationEntity? locationEntity;

  @override
  void initState() {
    if (widget.address != null) {
      locationEntity = LocationEntity(
          lat: double.parse(widget.address!.lat.toString()),
          lon: double.parse(widget.address!.lng.toString()),
          address: widget.address!.address ?? "");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Padding(
        padding: screenPadding(),
        child: Column(
          children: [
            Container(
              height: SizeConfig.bodyHeight * .02,
              color: context.colorScheme.surface,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .02,
            ),
            AddLocationMap(address: widget.address,),
            SizedBox(
              height: SizeConfig.bodyHeight * .04,
            ),
            CustomTextFormField(
              name: "name",
              initialValue: widget.address?.name??widget.address?.address,
              hintText: context.localizations.name,
              validator: FormBuilderValidators.required(
                  errorText: context.localizations.validation),
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .02,
            ),
            ChooseGovernorateAndRegion(
              governorate: widget.address?.province,
              city: widget.address?.region,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .02,
            ),
            PhoneFieldWidget(
              phone: widget.address?.phone??UserDataService().getUserData()?.phone,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .02,
            ),
            CustomTextFormField(
              name: "notes",
              initialValue: widget.address?.notes,
              maxLines: 6,
              hintText: context.localizations.notes,
              prefixIcon: AppImage.asset(Assets.icons.edit),
              validator: FormBuilderValidators.required(
                  errorText: context.localizations.validation),
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .1,
            ),
            BlocConsumer<AddNewAddressCubit, AddNewAddressState>(
              listener: (context, state) {
                if (state is AddNewAddressSuccess) {
                  Navigator.pop(context);
                  AppConstant.showCustomSnakeBar(context, state.msg, true);
                } else if (state is AddNewAddressFailure) {
                  AppConstant.showCustomSnakeBar(context, state.msg, false);
                }
              },
              builder: (context, state) {
                final bloc = context.read<AddNewAddressCubit>();
                return CustomButton(
                    text: widget.address == null
                        ? context.localizations.saveLocation
                        : context.localizations.updateLocation,
                    isLoading: state is AddNewAddressLoading,
                    press: () {
                      if (!_formKey.currentState!.saveAndValidate()) {
                        return;
                      }
                      SavedLocationParams params = SavedLocationParams(
                        name: _formKey.fieldValue("name"),
                        provinceId: _formKey.fieldValue("governorate").id,
                        regionId: _formKey.fieldValue("region").id,
                        phone: _formKey.fieldValue("phone"),
                        lat: locationEntity?.lat ?? context.read<LocationPickerCubit>().currentLocation?.latitude,
                        lng: locationEntity?.lon?? context.read<LocationPickerCubit>().currentLocation?.longitude,
                        address: locationEntity?.address,
                        notes: _formKey.fieldValue("notes"),
                      );
                      bloc.addNewAddress(saved: params, id: widget.address?.id);
                    });
              },
            ),
          ],
        ).scrollable(),
      ),
    );
  }
}
