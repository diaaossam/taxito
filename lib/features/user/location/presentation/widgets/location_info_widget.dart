import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../common/models/user_model_helper.dart';
import '../../../../../core/utils/api_config.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../cubit/my_address/my_address_cubit.dart';

class LocationInfoWidget extends StatefulWidget {
  final Function(num) onLocationSelected;

  const LocationInfoWidget({super.key, required this.onLocationSelected});

  @override
  State<LocationInfoWidget> createState() => _LocationInfoWidgetState();
}

class _LocationInfoWidgetState extends State<LocationInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyAddressCubit, MyAddressState>(
      listener: (context, state) {
        if (state is GetMyAddressSuccess) {
          setState(() {});
        }
        if (state is GetLocationCostSuccess) {
          widget.onLocationSelected(state.cost);
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: AppText.hint(
                fontWeight: FontWeight.w500,
                textSize: 12,
                text:
                    ApiConfig.myAddress?.address ??
                    "${UserDataService().getUserData()?.currentAddress?.address}",
              ),
            ),
            6.horizontalSpace,
            AppImage.asset(Assets.icons.arrowDown),
          ],
        );
      },
    );
  }
}
