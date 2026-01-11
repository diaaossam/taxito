import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_failure.dart';
import '../../../../../widgets/loading/loading_widget.dart';
import '../../../../location/presentation/cubit/location_cubit.dart';
import 'location_item_design.dart';

class ChooseLocationListDesign extends StatelessWidget {
  const ChooseLocationListDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        if (state is GetSuggestMapSuccess) {
          return Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => LocationItemDesign(
                        suggestionModel: state.list[index],
                      ),
                  separatorBuilder: (context, index) => 15.verticalSpace,
                  itemCount: state.list.length));
        } else if (state is GetSuggestMapFailure) {
          return AppFailureWidget(
            body: state.errorMsg,
          );
        } else if (state is GetPlaceDetailsByPlaceIdLoading) {
          return LoadingWidget(
            size: SizeConfig.bodyHeight * .03,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
