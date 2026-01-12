import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/extensions/widget_ext.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/main/presentation/pages/main_layout.dart';
import 'package:taxito/features/user/order/presentation/bloc/track/track_order_cubit.dart';
import 'package:taxito/features/user/order/presentation/widgets/order_details/order_location_design.dart';
import 'package:taxito/widgets/app_failure.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_divider_design.dart';
import 'package:taxito/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../widgets/custom_button.dart';
import '../../../../../captain/settings/settings_helper.dart';
import '../order_details/order_details_product.dart';
import '../order_details/order_info_card.dart';
import '../order_details/order_price_details.dart';
import 'order_rating_widget.dart';
import 'order_tracking_design.dart';

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
          return Padding(
            padding: screenPadding(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderInfoCard(orders: context.read<TrackOrderCubit>().orders!),
                OrderTrackingWidget(
                  orders: context.read<TrackOrderCubit>().orders!,
                  currentStep: getOrderState(
                    status: context
                        .read<TrackOrderCubit>()
                        .orders!
                        .status!
                        .name,
                  ),
                ),
                const CustomDividerDesign(),
                if (bloc.orders?.status == OrderType.delivered) ...[
                  SizedBox(height: SizeConfig.bodyHeight * .03),
                  OrderRatingWidget(orders: bloc.orders!),
                  SizedBox(height: SizeConfig.bodyHeight * .02),
                ],
                Padding(
                  padding: screenPadding(),
                  child: AppText(
                    text: context.localizations.orderDetails,
                    fontWeight: FontWeight.w600,
                    textSize: 14,
                  ),
                ),
                SizedBox(height: SizeConfig.bodyHeight * .01),
                OrderDetailsProduct(orders: bloc.orders!),
                SizedBox(height: SizeConfig.bodyHeight * .01),
                const CustomDividerDesign(),
                SizedBox(height: SizeConfig.bodyHeight * .01),
                if (bloc.orders!.address != null) ...[
                  OrderLocationDesign(address: bloc.orders!.address!),
                  SizedBox(height: SizeConfig.bodyHeight * .01),
                  const CustomDividerDesign(),
                  SizedBox(height: SizeConfig.bodyHeight * .01),
                ],
                PaymentPriceOrder(orders: bloc.orders!),
                SizedBox(height: SizeConfig.bodyHeight * .04),
                if (bloc.orders!.status == OrderType.pending)
                  BlocConsumer<TrackOrderCubit, TrackOrderState>(
                    listener: (context, state) {
                      if (state is DeleteOrderSuccess) {
                        context.navigateToAndFinish(const MainLayout());
                        AppConstant.showCustomSnakeBar(
                          context,
                          state.msg,
                          true,
                        );
                      }
                      if (state is DeleteOrderFailure) {
                        AppConstant.showCustomSnakeBar(
                          context,
                          state.msg,
                          false,
                        );
                      }
                    },
                    builder: (context, state) {
                      final bloc = context.read<TrackOrderCubit>();
                      return CustomButton(
                        text: context.localizations.cancelOrder,
                        isLoading: state is DeleteOrderLoading,
                        press: () {
                          SettingsHelper().showAppDialog(
                            height: SizeConfig.bodyHeight * .33,
                            context: context,
                            title: context.localizations.cancelOrderBody,
                            isAccept: (p0) {
                              if (p0) {
                                bloc.deleteOrder(orderId: bloc.orders!.id ?? 1);
                              }
                            },
                          );
                        },
                        borderColor: context.colorScheme.error,
                        textColor: context.colorScheme.error,
                        backgroundColor: context.colorScheme.onErrorContainer,
                      );
                    },
                  ),
                SizedBox(height: SizeConfig.bodyHeight * .04),
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
