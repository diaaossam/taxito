import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/user/order/order_helper.dart';
import 'package:taxito/features/user/order/presentation/pages/track_order.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import 'package:taxito/features/common/models/orders.dart';

class OrderItemDesign extends StatelessWidget {
  final Orders orders;
  final VoidCallback? onCancel;
  final VoidCallback? onRepeat;
  final VoidCallback? onTrack;
  final bool isLoading;

  const OrderItemDesign({
    super.key,
    required this.orders,
    this.onCancel,
    this.onRepeat,
    required this.isLoading,
    this.onTrack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * .04,
        vertical: SizeConfig.bodyHeight * .03,
      ),
      margin: EdgeInsets.symmetric(vertical: SizeConfig.bodyHeight * .015),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outline),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImage.asset(getImage(), height: 50.h, width: 50.h),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        AppText(
                          text: "${context.localizations.orderNumber} :",
                          fontWeight: FontWeight.w600,
                          textSize: 12,
                        ),
                        6.horizontalSpace,
                        AppText(
                          text: "#${orders.orderNumber}",
                          fontWeight: FontWeight.w600,
                          color: context.colorScheme.tertiary,
                          textSize: 12,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    AppText(
                      text: "${orders.finalPrice} ${context.localizations.iqd}",
                      fontWeight: FontWeight.w600,
                      textSize: 12,
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        AppText(
                          color: context.colorScheme.shadow,
                          textSize: 12,
                          text: OrderHelper().formatDateTime(
                            orders.createdAt ?? DateTime.now(),
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.bodyHeight * .01),
          if (isLoading)
            const LoadingWidget()
          else
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    height: 40.h,
                    textSize: 11,
                    radius: 12,
                    text: context.localizations.orderDetails,
                    press: () => context.navigateTo(
                      TrackOrderScreen(id: orders.id ?? 0),
                    ),
                  ),
                ),
                if (orders.status == OrderType.pending) ...[
                  10.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      height: 40.h,
                      textSize: 11,
                      radius: 12,
                      backgroundColor: Colors.transparent,
                      textColor: context.colorScheme.error,
                      borderColor: context.colorScheme.error,
                      text: context.localizations.cancelOrder,
                      press: onCancel ?? () {},
                    ),
                  ),
                ],
                if (orders.status == OrderType.delivered) ...[
                  10.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      height: 40.h,
                      textSize: 11,
                      radius: 12,
                      backgroundColor: Colors.transparent,
                      textColor: context.colorScheme.primary,
                      borderColor: context.colorScheme.primary,
                      text: context.localizations.cancelOrder,
                      press: onCancel ?? () {},
                    ),
                  ),
                ],
                if (orders.status == OrderType.outForDeleivery) ...[
                  10.horizontalSpace,
                  Expanded(
                    child: CustomButton(
                      height: 40.h,
                      textSize: 11,
                      radius: 12,
                      backgroundColor: Colors.transparent,
                      textColor: context.colorScheme.primary,
                      borderColor: context.colorScheme.primary,
                      text: context.localizations.trackOrder,
                      press: onTrack ?? () {},
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }

  String getImage() {
    switch (orders.status) {
      case null:
        return Assets.images.pending.path;
      case OrderType.pending:
        return Assets.images.pending.path;
      case OrderType.confirmed:
        return Assets.images.confirmed.path;
      case OrderType.outForDeleivery:
        return Assets.images.outForDeleivery.path;
      case OrderType.delivered:
        return Assets.images.deleivered.path;
      case OrderType.canceled:
        return Assets.images.canceled.path;
      case OrderType.inPreparation:
        return Assets.images.confirmed.path;
      case OrderType.readyForDeleivery:
        return Assets.images.confirmed.path;
    }
  }
}
