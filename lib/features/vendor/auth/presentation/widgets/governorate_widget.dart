import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../../core/data/models/user_model_helper.dart';
import '../../../../../core/extensions/app_localizations_extension.dart';
import '../../../../../widgets/app_drop_down.dart';
import '../../../../../widgets/app_text.dart';
import '../../../location/presentation/cubit/governorate/governorate_bloc.dart';
import '../../../location/presentation/widget/location_picket_widget.dart';

class GovernorateWidget extends StatefulWidget {
  final bool showLabel;

  const GovernorateWidget({super.key, required this.showLabel});

  @override
  State<GovernorateWidget> createState() => _GovernorateWidgetState();
}

class _GovernorateWidgetState extends State<GovernorateWidget> {
  @override
  void initState() {
    if (UserDataService().getUserData()?.province != null) {
      num id = UserDataService().getUserData()!.province!.id!.toInt();
      context.read<GovernorateBloc>().add(GetAllRegionEvent(id: id));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GovernorateBloc, GovernorateState>(
      builder: (context, state) {
        final bloc = context.read<GovernorateBloc>();
        return Column(
          children: [
            AppDropDown<int>(
              initialValue: state is GetAllGovernorateSuccess
                  ? UserDataService().getUserData()?.province?.id
                  : null,
              label: context.localizations.governorate,
              hint: context.localizations.governorate,
              title: context.localizations.governorate,
              onChanged: (p0) => bloc.add(GetAllRegionEvent(id: p0!)),
              isLoading: state is GetAllGovernorateLoading,
              validator: FormBuilderValidators.required(
                errorText: context.localizations.validation,
              ),
              items: bloc.governorate
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.id,
                      child: AppText(text: e.title.toString()),
                    ),
                  )
                  .toList(),
              name: "governorate",
            ),
            20.verticalSpace,
            if (state is GetAllRegionLoading)
              const SizedBox()
            else
              AppDropDown<int>(
                label: context.localizations.region,
                hint: context.localizations.region,
                initialValue: UserDataService().getUserData()?.region?.id,
                title: context.localizations.region,
                isLoading: state is GetAllRegionLoading,
                validator: FormBuilderValidators.required(
                  errorText: context.localizations.validation,
                ),
                items: bloc.region
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: AppText(text: e.title.toString()),
                      ),
                    )
                    .toList(),
                name: "region",
              ),
            20.verticalSpace,
            LocationPickerWidget(
              initialAddress: UserDataService().getUserData()?.address,
              initialLat: UserDataService().getUserData()?.lat,
              initialLng: UserDataService().getUserData()?.lng,
            ),
          ],
        );
      },
    );
  }
}
