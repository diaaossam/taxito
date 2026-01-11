import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/api_config.dart';
import 'package:aslol/features/location/location_helper.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../settings/settings_helper.dart';

class CartLocationDesign extends StatefulWidget {
  const CartLocationDesign({super.key});

  @override
  State<CartLocationDesign> createState() => _CartLocationDesignState();
}

class _CartLocationDesignState extends State<CartLocationDesign> {

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * .02,
            vertical: SizeConfig.bodyHeight * .02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: context.localizations.address1,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .02,
            ),
            if (ApiConfig.myAddress == null)
              Padding(
                padding: screenPadding(),
                child: CustomButton(
                    radius: 14,
                    height: 45.h,
                    backgroundColor: context.colorScheme.onPrimaryFixed,
                    text: context.localizations.addAddressDeleivery,
                    press: () async{
                      await LocationHelper().showLocationDailog(
                        context: context,
                        myAddress: (p0) {
                          if(ApiConfig.isGuest == true){
                            SettingsHelper().showGuestDialog(context);
                            return;
                          }
                          Navigator.pop(context);
                          setState(() {});
                        },
                      );
                    }),
              )
            else
              GestureDetector(
                onTap: () async {
                  await LocationHelper().showLocationDailog(
                    context: context,
                    myAddress: (p0) {
                      Navigator.pop(context);
                      setState(() {});
                    },
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.screenWidth * .03,
                      vertical: SizeConfig.bodyHeight * .02),
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(14)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.colorScheme.surface,
                            border:
                                Border.all(color: context.colorScheme.outline),
                          ),
                          child: AppImage.asset(
                            Assets.icons.location2,
                            color: context.colorScheme.primary,
                            height: SizeConfig.bodyHeight * .02,
                          )),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text: ApiConfig.myAddress?.name ?? "",
                              fontWeight: FontWeight.w500,
                              textSize: 12,
                            ),
                            7.verticalSpace,
                            AppText(
                              text: ApiConfig.myAddress?.notes ?? "",
                              textSize: 11,
                              maxLines: 2,
                              color: context.colorScheme.shadow,
                            ),
                          ],
                        ),
                      ),
                      10.horizontalSpace,
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * .04,
                            vertical: SizeConfig.bodyHeight * .01),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: context.colorScheme.primary),
                            color: context.colorScheme.onPrimary,
                            borderRadius: BorderRadius.circular(8)),
                        child: AppText(
                          text: context.localizations.edit,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
