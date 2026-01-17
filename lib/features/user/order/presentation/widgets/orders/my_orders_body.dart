import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/orders/orders_cubit.dart';
import 'my_orders_tab_bar.dart';
import 'order_list_design.dart';

class MyOrdersBody extends StatefulWidget {
  const MyOrdersBody({super.key});

  @override
  State<MyOrdersBody> createState() => _MyOrdersBodyState();
}

class _MyOrdersBodyState extends State<MyOrdersBody>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 8, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        final bloc = context.read<OrdersCubit>();
        return Column(
          children: [
            TabBarDesign(
              tabController: tabController,
              tabs: [
                Tab(
                  text: context.localizations.allProduct,
                ),
                Tab(
                  text: context.localizations.current2,
                ),
                Tab(
                  text: context.localizations.confirmed,
                ),
                Tab(
                  text: context.localizations.inPreparation,
                ),
                Tab(
                  text: context.localizations.orderDonePrepare,
                ),
                Tab(
                  text: context.localizations.outForDeleivery,
                ),
                Tab(
                  text: context.localizations.delivered,
                ),
                Tab(
                  text: context.localizations.canceled,
                ),
              ],
            ),
            SizedBox(height: SizeConfig.bodyHeight*.02,),
            Expanded(
              child: TabBarView(controller: tabController, children: [
                OrderListDesign(
                  pagingController: bloc.pagingControllerAllProducts,
                  
                ), OrderListDesign(
                  pagingController: bloc.pagingControllerPending,
                  orderType: OrderType.pending,
                ),
                OrderListDesign(
                  pagingController: bloc.pagingControllerConfirmed,
                  orderType: OrderType.confirmed,
                ),
                OrderListDesign(
                  pagingController: bloc.pagingControllerInPrepareSupplier,
                  orderType: OrderType.inPreparation,
                ),
                OrderListDesign(
                  pagingController: bloc.pagingControllerDonePrepare,
                  orderType: OrderType.readyForDeleivery,
                ),
                OrderListDesign(
                  pagingController: bloc.pagingControllerOutForDeleivery,
                  orderType: OrderType.outForDeleivery,
                ),
                OrderListDesign(
                  pagingController: bloc.pagingControllerDelivered,
                  orderType: OrderType.delivered,
                ),
                OrderListDesign(
                  pagingController: bloc.pagingControllerCanceled,
                  orderType: OrderType.canceled,
                ),
              ]),
            )
          ],
        );
      },
    );
  }
}
