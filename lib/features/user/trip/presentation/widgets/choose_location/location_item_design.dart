import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../../../widgets/rotate.dart';
import '../../../../location/data/models/response/suggestion_model.dart';
import '../../../../location/presentation/cubit/location_cubit.dart';

class LocationItemDesign extends StatelessWidget {
  final SuggestionModel suggestionModel;

  const LocationItemDesign({super.key, required this.suggestionModel});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        final bloc = context.read<LocationCubit>();
        return InkWell(
          onTap: () =>
              bloc.getPlaceDetailsByPlaceId(suggestionModel: suggestionModel),
          child: Row(
            children: [
              Rotate(child: AppImage.asset(Assets.icons.arrowBack)),
              AppText(
                text: suggestionModel.name ?? "",
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        );
      },
    );
  }
}
