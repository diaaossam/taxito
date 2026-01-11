import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../data/models/location_entity.dart';
import '../pages/google_map_screen.dart';

class LocationPickerWidget extends StatelessWidget {
  final String? initialAddress;
  final String? initialLat;
  final String? initialLng;

  const LocationPickerWidget({
    super.key,
    this.initialAddress,
    this.initialLat,
    this.initialLng,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<LocationEntity>(
      name: "location",
      validator:  FormBuilderValidators.required(
          errorText: context.localizations.validation

      ),
      initialValue: initialAddress != null && initialLat != null && initialLng != null
          ? LocationEntity(
              address: initialAddress!,
              lat: double.parse(initialLat!),
              lon: double.parse(initialLng!),
            )
          : null,
      builder: (field) => CustomTextFormField(
        readOnly: true,
        validator: FormBuilderValidators.required(
          errorText: context.localizations.validation
        ) ,
        initialValue: initialAddress,
        onTap: () async {
          context.navigateTo(
            const GoogleMapScreen(),
            callback: (p0) {
              if (p0 != null) {
                LocationEntity location = p0;
                FormBuilder.of(context)
                    ?.fields['locationName']
                    ?.didChange(location.address);
                field.didChange(p0);
              }
            },
          );
        },
        name: "locationName",
        hintText: context.localizations.addLocationOnMap,
        label: context.localizations.addLocationOnMap,

      ),
    );
  }
}
