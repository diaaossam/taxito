import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../widgets/app_drop_down.dart';
import '../../../../../widgets/app_text.dart';
import '../../../location/presentation/cubit/governorate/governorate_bloc.dart';
import '../../data/models/response/user_model_helper.dart';

class GovernorateWidget extends StatelessWidget {
  final bool showLabel;

  const GovernorateWidget({super.key, required this.showLabel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<GovernorateBloc>()..add(GetAllGovernorateEvent()),
      child: BlocBuilder<GovernorateBloc, GovernorateState>(
        builder: (context, state) {
          return AppDropDown<int>(
            initialValue:state is GetAllGovernorateSuccess ?  UserDataService().getUserData()?.province?.id : null,
            label: context.localizations.governorate,
            hint: context.localizations.governorate,
            title: context.localizations.governorate,
            isLoading: state is GetAllGovernorateLoading,
            validator: FormBuilderValidators.required(errorText: context.localizations.validation),
            items: state is GetAllGovernorateSuccess
                ? (state)
                    .list
                    .map((e) => DropdownMenuItem(
                          value: e.id,
                          child: AppText(
                            text: e.title.toString(),
                          ),
                        ))
                    .toList()
                : [],
            name: "governorate",
          );
        },
      ),
    );
  }
}
