import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/vendor/order/presentation/widgets/track_order/product_info_widget.dart';
import 'package:taxito/widgets/app_failure.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../cubit/track/track_order_cubit.dart';
import 'order_info_card.dart';
import 'order_payment_info.dart';
import 'order_persons_info.dart';
import 'order_price_summary.dart';

class TrackOrderBody extends StatelessWidget {
  const TrackOrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackOrderCubit, TrackOrderState>(
      builder: (context, state) {
        final bloc = context.read<TrackOrderCubit>();
        if (state is GetOrderDetailsLoading) {
          return const LoadingWidget();
        } else if (_getState(state)) {
          final order = bloc.orders!;
          return Padding(
            padding: screenPadding(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderInfoCard(orders: context.read<TrackOrderCubit>().orders!),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        order.supplier?.profileImage ?? '',
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AppText(
                            text: order.supplier?.name ?? "",
                            color: context.colorScheme.shadow,
                            textSize: 12,
                          ),
                          10.verticalSpace,
                          AppText(
                            text: order.supplier?.address ?? "",
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
                                order.address?.name ??
                                order.address?.address ??
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
                OrderDetailsProduct(orders: order),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                OrderPersonsInfo(orders: order),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                OrderPaymentInfo(orders: order),
                SizedBox(height: SizeConfig.bodyHeight * .02),
                OrderPriceSummary(orders: order),
                SizedBox(height: SizeConfig.bodyHeight * .02),
              ],
            ).scrollable(),
          );
        } else if (state is GetOrderDetailsFailure) {
          return const AppFailureWidget();
        } else {
          return const Center();
        }
      },
    );
  }

  int getOrderState({required String status}) {
    if (status == "under_review") {
      return 0;
    } else if (status == "confirmed") {
      return 1;
    } else if (status == "in_progress") {
      return 2;
    } else if (status == "out_for_delivery") {
      return 3;
    } else if (status == "delivered") {
      return 4;
    } else {
      return 0;
    }
  }

  bool _getState(TrackOrderState state) {
    return state is GetOrderDetailsSuccess ||
        state is DeleteOrderLoading ||
        state is DeleteOrderSuccess ||
        state is DeleteOrderFailure;
  }
}
