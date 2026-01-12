import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/user/location/presentation/cubit/my_address/my_address_cubit.dart';
import 'package:taxito/features/user/location/presentation/pages/add_address_screen.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../captain/delivery_order/data/models/response/my_address.dart';
import '../../../../captain/settings/settings_helper.dart';

class AddressItemDesign extends StatelessWidget {
  final MyAddress address;
  final bool isSelected;
  final bool showActions;
  final VoidCallback callback;

  const AddressItemDesign({
    super.key,
    required this.address,
    required this.isSelected,
    required this.showActions,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * .03,
        vertical: SizeConfig.bodyHeight * .02,
      ),
      decoration: BoxDecoration(
        color: isSelected ? context.colorScheme.onPrimary : Colors.transparent,
        border: isSelected
            ? Border.all(color: context.colorScheme.primary)
            : null,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isSelected) ...{
            AppImage.asset(Assets.icons.radio),
            10.horizontalSpace,
          },
          AppImage.asset(
            Assets.images.maps.path,
            height: SizeConfig.bodyHeight * .1,
          ),
          10.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: address.name ?? context.localizations.defaultLocation,
                  fontWeight: FontWeight.bold,
                  textSize: 14,
                ),
                7.verticalSpace,
                AppText(
                  text: address.address ?? "",
                  textSize: 11,
                  maxLines: 2,
                  color: context.colorScheme.shadow,
                ),
              ],
            ),
          ),
          10.horizontalSpace,
          if (showActions) ...{
            Column(
              children: [
                InkWell(
                  onTap: () =>
                      context.navigateTo(AddAddressScreen(address: address)),
                  child: AppImage.asset(
                    Assets.icons.edit,
                    color: context.colorScheme.primary,
                  ),
                ),
                8.verticalSpace,
                InkWell(
                  onTap: () => SettingsHelper().showAppDialog(
                    context: context,
                    height: SizeConfig.bodyHeight * .34,
                    isAccept: (p0) {
                      if (p0) {
                        context.read<MyAddressCubit>().deleteAddress(
                          id: address.id ?? 1,
                        );
                      }
                    },
                    image: Assets.icons.trash,
                    title: context.localizations.doYouWantToDeleteAddress,
                  ),
                  child: AppImage.asset(Assets.icons.trash),
                ),
              ],
            ),
          },
        ],
      ),
    );
  }
}
