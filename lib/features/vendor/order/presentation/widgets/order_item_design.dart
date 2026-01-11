import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../data/models/response/orders.dart';
import '../../order_helper.dart';
import '../cubit/delivery_actions/delivery_actions_cubit.dart';

class OrderItemDesign extends StatefulWidget {
  final Orders orders;
  final Function(Orders)? onReject;
  final Function(Orders)? onAccept;
  final Function(Orders)? onGetDetails;
  final Function(Orders)? onChangeStatus;
  final String? statusText;
  final bool isLoading;
  final Color? backgroundColor;

  const OrderItemDesign({
    super.key,
    required this.orders,
    this.onReject,
    this.statusText,
    this.onAccept,
    this.onGetDetails,
    this.onChangeStatus,
    required this.isLoading,
    this.backgroundColor,
  });

  @override
  State<OrderItemDesign> createState() => _OrderItemDesignState();
}

class _OrderItemDesignState extends State<OrderItemDesign> {
  int? _remainingSeconds;

  @override
  void initState() {
    super.initState();
    if (widget.onAccept != null &&
        widget.onReject != null &&
        widget.orders.id != null &&
        widget.orders.showTimer == true) {
      final cubit = context.read<DeliveryActionsCubit>();
      _remainingSeconds = cubit.getRemainingSeconds(widget.orders.id!);
    }
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliveryActionsCubit, DeliveryActionsState>(
      listener: (context, state) {
        if (state is OrderTimerUpdateState &&
            state.orderId == widget.orders.id) {
          setState(() => _remainingSeconds = state.remainingSeconds);
        }
      },
      child: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
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
                            text: "#${widget.orders.orderNumber}",
                            fontWeight: FontWeight.w600,
                            color: context.colorScheme.tertiary,
                            textSize: 12,
                          ),
                        ],
                      ),
                      10.verticalSpace,
                      AppText(
                        text:
                            "${widget.orders.finalPrice} ${context.localizations.iqd}",
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
                              widget.orders.createdAt ?? DateTime.now(),
                            ),
                          ),
                        ],
                      ),
                      10.verticalSpace,
                    ],
                  ),
                ),
                10.horizontalSpace,
                AppText(
                  text: handleOrderTypeToString(code: widget.orders.status!),
                  fontWeight: FontWeight.w600,
                  textSize: 11,
                  color: context.colorScheme.tertiary,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.bodyHeight * .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                    widget.orders.supplier?.profileImage ?? '',
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        text: widget.orders.supplier?.name ?? "",
                        color: context.colorScheme.shadow,
                        textSize: 12,
                      ),
                      10.verticalSpace,
                      AppText(
                        text: widget.orders.supplier?.address ?? "",
                        maxLines: 2,
                        textSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsetsDirectional.only(start: 10.w),
              height: 25.h,
              color: context.colorScheme.outline.withOpacity(0.5),
              width: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppImage.asset(
                  Assets.icons.location,
                  height: SizeConfig.bodyHeight * .03,
                  color: context.colorScheme.primary,
                ),
                10.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      AppText(
                        text: context.localizations.deliveryAddress,
                        color: context.colorScheme.shadow,
                        textSize: 12,
                      ),
                      10.verticalSpace,
                      AppText(
                        text:
                            widget.orders.address?.name ??
                            widget.orders.address?.address ??
                            '',
                        maxLines: 2,
                        textSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            if (widget.isLoading)
              const LoadingWidget()
            else ...[
              if (widget.onAccept != null &&
                  widget.onReject != null &&
                  _remainingSeconds != null &&
                  widget.orders.showTimer == true) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 8.h,
                  ),
                  margin: EdgeInsets.only(bottom: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: context.colorScheme.shadow,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${context.localizations.ifNotAcceptedWithin} ',
                              ),
                              TextSpan(
                                text: _formatTime(_remainingSeconds!),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.error,
                                  fontSize: 12.sp,
                                ),
                              ),
                              TextSpan(
                                text:
                                    ', ${context.localizations.willBeTransferred}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              Row(
                children: [
                  if (widget.onAccept != null)
                    Expanded(
                      child: CustomButton(
                        height: 40.h,
                        textSize: 11,
                        radius: 12,
                        backgroundColor: context.colorScheme.tertiary,
                        borderColor: context.colorScheme.tertiary,
                        text: context.localizations.accept,
                        press: () => widget.onAccept!(widget.orders),
                      ),
                    ),
                  10.horizontalSpace,
                  if (widget.onReject != null)
                    Expanded(
                      child: CustomButton(
                        height: 40.h,
                        textSize: 11,
                        radius: 12,
                        backgroundColor: Colors.transparent,
                        textColor: context.colorScheme.error,
                        borderColor: context.colorScheme.error,
                        text: context.localizations.reject,
                        press: () => widget.onReject!(widget.orders),
                      ),
                    ),
                ],
              ),
              10.verticalSpace,
              if (widget.onGetDetails != null) ...[
                CustomButton(
                  height: 40.h,
                  textSize: 11,
                  radius: 12,
                  text: context.localizations.orderDetails,
                  press: () => widget.onGetDetails!(widget.orders),
                ),
                10.verticalSpace,
              ],
              if (widget.onChangeStatus != null)
                CustomButton(
                  height: 40.h,
                  textSize: 11,
                  radius: 12,
                  backgroundColor:
                      widget.backgroundColor ?? const Color(0xff00ABB9),
                  borderColor:
                      widget.backgroundColor ?? const Color(0xff00ABB9),
                  text: widget.statusText,
                  press: () => widget.onChangeStatus!(widget.orders),
                ),
            ],
          ],
        ),
      ),
    );
  }

  String getImage() {
    print(widget.orders.status);
    switch (widget.orders.status) {
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
        return Assets.images.pending.path;
      case OrderType.readyForDeleivery:
        return Assets.images.pending.path;
    }
  }
}
