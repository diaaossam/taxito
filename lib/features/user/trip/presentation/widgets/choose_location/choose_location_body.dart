import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/custom_text_form_field.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../../location/presentation/cubit/location_cubit.dart';
import 'choose_location_list_design.dart';

class ChooseLocationBody extends StatelessWidget {
  final bool isStart;

  const ChooseLocationBody({super.key, required this.isStart});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit, LocationState>(
      listener: (context, state) {
        if (state is GetPlaceDetailsByPlaceIdSuccess) {
          Navigator.pop(context, state.location);
        }
      },
      builder: (context, state) {
        final bloc = context.read<LocationCubit>();
        return Padding(
          padding: screenPadding(),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
              CustomTextFormField(
                hintText: context.localizations.search,
                onChanged: (value) => value != null && value.isNotEmpty
                    ? bloc.fetchSuggestion(query: value)
                    : null,
                prefixIcon: AppImage.asset(
                  Assets.icons.location,
                  color: context.colorScheme.primary,
                ),
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
              const ChooseLocationListDesign(),
            ],
          ),
        );
      },
    );
  }
}
