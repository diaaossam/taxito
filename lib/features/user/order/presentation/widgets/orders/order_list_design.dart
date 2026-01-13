import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/order/presentation/bloc/track/track_order_cubit.dart';
import 'package:taxito/widgets/app_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../captain/settings/settings_helper.dart';
import 'package:taxito/features/common/models/orders.dart';
import '../../bloc/orders/orders_cubit.dart';
import 'order_item_design.dart';

class OrderListDesign extends StatefulWidget {
  final PagingController<int, Orders> pagingController;
  final OrderType orderType;

  const OrderListDesign({
    super.key,
    required this.pagingController,
    required this.orderType,
  });

  @override
  State<OrderListDesign> createState() => _OrderListDesignState();
}

class _OrderListDesignState extends State<OrderListDesign> {
  @override
  void initState() {
    if (mounted) {
      widget.pagingController.addPageRequestListener((pageKey) {
        final bloc = context.read<OrdersCubit>();
        bloc.fetchPage(pageKey, widget.orderType, widget.pagingController);
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TrackOrderCubit, TrackOrderState>(
      listener: (context, state) {
        if (state is DeleteOrderSuccess) {
          AppConstant.showCustomSnakeBar(context, state.msg, true);
          widget.pagingController.itemList?.removeWhere(
            (element) => element.id == state.id,
          );
        } else if (state is DeleteOrderFailure) {
          AppConstant.showCustomSnakeBar(context, state.msg, false);
        }
      },
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            if (mounted) {
              widget.pagingController.refresh();
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: screenPadding(),
                sliver: PagedSliverList(
                  pagingController: widget.pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    noItemsFoundIndicatorBuilder: (context) => Opacity(
                      opacity: 0.4,
                      child: AppFailureWidget(
                        title: context.localizations.noOrders,
                        body: context.localizations.noOrdersBody,
                        buttonText: context.localizations.reload,
                        callback: () => widget.pagingController.refresh(),
                      ),
                    ),
                    itemBuilder: (context, Orders item, index) =>
                        OrderItemDesign(
                          orders: item,
                          isLoading:
                              state is DeleteOrderLoading &&
                              state.id == item.id,
                          onCancel: () {
                            SettingsHelper().showAppDialog(
                              height: SizeConfig.bodyHeight * .33,
                              context: context,
                              title: context.localizations.cancelOrderBody,
                              isAccept: (p0) {
                                if (p0) {
                                  context.read<TrackOrderCubit>().deleteOrder(
                                    orderId: item.id ?? 0,
                                  );
                                }
                              },
                            );
                          },
                          onRepeat: () {},
                        ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
