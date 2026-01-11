import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/auth/data/models/response/user_model.dart';
import 'package:aslol/features/trip/data/models/trip_model.dart';
import 'package:aslol/features/trip/presentation/widgets/request_trip/comminucation_with_driver_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_size.dart';
import '../../../../gen/assets.gen.dart';
import '../../../../widgets/app_text.dart';

class DriverInfoWidget extends StatelessWidget {
  final UserModel driver;
  final TripModel trip;
  const DriverInfoWidget({super.key, required this.driver, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colorScheme.onPrimary),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.colorScheme.outline,
            ),
            color: context.colorScheme.onPrimary),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                  Border.all(color: context.colorScheme.primary)),
              child: CircleAvatar(
                maxRadius: 25,
                backgroundImage: NetworkImage(driver.image ?? ""),
                onBackgroundImageError: (exception, stackTrace) => AssetImage(Assets.images.dummyUser.path),
              ),
            ),
            10.horizontalSpace,
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: SizeConfig.bodyHeight * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: "${driver.name}",
                                fontWeight: FontWeight.w600,
                                textSize: 13,
                              ),
                              8.verticalSpace,
                              Directionality(
                                textDirection: TextDirection.ltr,
                                child: AppText(
                                  text: trip.driver?.phone??"",
                                  fontWeight: FontWeight.w600,
                                  textSize: 12,
                                  color: context.colorScheme.shadow,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ComminucationWithDriverWidget(
                          tripModel: trip,
                          onCallBack: (p0) {},
                        ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
