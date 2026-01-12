import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/location/presentation/cubit/globale_location/global_location_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../widgets/app_drop_down.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../captain/app/data/models/generic_model.dart';

class ChooseGovernorateAndRegion extends StatefulWidget {
  final GenericModel? governorate;
  final GenericModel? city;

  const ChooseGovernorateAndRegion({super.key, this.governorate, this.city});

  @override
  State<ChooseGovernorateAndRegion> createState() =>
      _ChooseGovernorateAndRegionState();
}

class _ChooseGovernorateAndRegionState
    extends State<ChooseGovernorateAndRegion> {
  bool isUpdateGovernorate = false;

  @override
  void initState() {
    if (widget.governorate != null) {
      context.read<GlobalLocationCubit>().fetchRegion(
        id: widget.governorate!.id ?? 0,
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GlobalLocationCubit, GlobalLocationState>(
      builder: (context, state) {
        final bloc = context.read<GlobalLocationCubit>();
        return Column(
          children: [
            AppDropDown<GenericModel>(
              name: "governorate",
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
              onChanged: (GenericModel? p0) {
                setState(() => isUpdateGovernorate = true);
                bloc.fetchRegion(id: p0?.id ?? 0);
              },
              initialValue: bloc.governorates.isNotEmpty
                  ? widget.governorate
                  : null,
              hint: context.localizations.governorate,
              items: bloc.governorates
                  .map<DropdownMenuItem<GenericModel>>(
                    (element) => DropdownMenuItem<GenericModel>(
                      value: element,
                      child: AppText(text: element.title ?? ""),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            AppDropDown<GenericModel>(
              name: "region",
              initialValue: bloc.region.isEmpty || isUpdateGovernorate
                  ? null
                  : widget.city,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
              hint: context.localizations.region,
              items: bloc.region
                  .map<DropdownMenuItem<GenericModel>>(
                    (element) => DropdownMenuItem<GenericModel>(
                      value: element,
                      child: AppText(text: element.title ?? ""),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
