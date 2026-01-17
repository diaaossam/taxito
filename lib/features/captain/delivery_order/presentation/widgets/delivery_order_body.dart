import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/delivery_order/data/models/request/delivery_order_params.dart';
import 'package:taxito/features/captain/delivery_order/presentation/cubit/delivery_actions/delivery_actions_cubit.dart';
import 'package:taxito/features/captain/delivery_order/presentation/cubit/delivery_order_cubit.dart';
import 'package:taxito/features/captain/delivery_order/presentation/pages/track_order.dart';
import 'package:taxito/features/captain/delivery_order/presentation/widgets/tab_bar_design.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/enum/trip_status_enum.dart';
import '../../../delivery_main/presentation/cubit/delivery_location/delivery_location_cubit.dart';
import 'delivery_order_list.dart';

class DeliveryOrderBody extends StatefulWidget {
  final bool showTitle;
  final num? id;

  const DeliveryOrderBody({super.key, required this.showTitle, this.id});

  @override
  State<DeliveryOrderBody> createState() => _DeliveryOrderBodyState();
}

class _DeliveryOrderBodyState extends State<DeliveryOrderBody>
    with SingleTickerProviderStateMixin {
  final ValueNotifier<int> listenableCompany = ValueNotifier(0);
  late TabController controller;
  TripStatusEnum tripStatusEnum = TripStatusEnum.coming;

  @override
  void initState() {
    if (widget.id != null) {
      context.read<DeliveryActionsCubit>().getOrderDetails(
        id: widget.id!.toInt(),
      );
    }
    controller = TabController(length: 6, vsync: this);
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<DeliveryLocationCubit>(),
      child: BlocConsumer<DeliveryActionsCubit, DeliveryActionsState>(
        listener: (context, state) {
          final orderCubit = context.read<DeliveryOrderCubit>();
          if (state is GetOrderInfoSuccess) {
            switch (state.orders.status) {
              case null:
                controller.animateTo(0);
                return;
              case OrderType.pending:
                controller.animateTo(0);
                return;
              case OrderType.inPreparation:
                controller.animateTo(1);
                return;
              case OrderType.confirmed:
                controller.animateTo(1);
                return;
              case OrderType.readyForDeleivery:
                controller.animateTo(2);
                return;
              case OrderType.outForDeleivery:
                controller.animateTo(3);
                return;

              case OrderType.delivered:
                controller.animateTo(4);
                return;
              case OrderType.canceled:
                controller.animateTo(5);
                return;
            }
          }

          if (state is UpdateOrderFailure) {
            AppConstant.showCustomSnakeBar(context, state.msg, false);
          }

          if (state is OrderAutoRejectedState) {
            orderCubit.removeOrderFromPending(state.order.id!.toInt());
          }
          if (state is RejectTripRequestSuccessState) {
            orderCubit.removeOrderFromController(
              orderCubit.pagingControllerNew,
              state.orders.id!.toInt(),
            );
            orderCubit.addOrderToController(
              orderCubit.pagingControllerCanceled,
              state.orders,
            );
          }

          if (state is UpdateOrderSuccess) {
            orderCubit.moveOrderBetweenTabs(
              orderId: state.id,
              newStatus: state.status,
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<DeliveryActionsCubit>();
          return RefreshIndicator(
            onRefresh: () async => _init(isRefresh: true),
            child: CustomScrollView(
              slivers: [
                if (widget.showTitle)
                  SliverToBoxAdapter(
                    child: AppText(
                      text: context.localizations.orders,
                      fontWeight: FontWeight.bold,
                      textSize: 15,
                    ),
                  ),
                SliverToBoxAdapter(
                  child: SizedBox(height: SizeConfig.bodyHeight * .02),
                ),
                SliverToBoxAdapter(
                  child: TabBarOrdersDesign(
                    onTap: (p0) {
                      final orderBloc = context.read<DeliveryOrderCubit>();
                      // Refresh the selected tab's orders
                      if (p0 == 0) {
                        orderBloc.pagingControllerNew.refresh();
                      } else if (p0 == 1) {
                        orderBloc.pagingControllerInPrepareSupplier.refresh();
                      } else if (p0 == 2) {
                        orderBloc.pagingControllerDonePrepare.refresh();
                      } else if (p0 == 3) {
                        orderBloc.pagingControllerWithDelegate.refresh();
                      } else if (p0 == 4) {
                        orderBloc.pagingControllerDelivered.refresh();
                      } else if (p0 == 5) {
                        orderBloc.pagingControllerCanceled.refresh();
                      }
                    },
                    tabController: controller,
                  ),
                ),
                SliverFillRemaining(
                  child: BlocBuilder<DeliveryOrderCubit, DeliveryOrderState>(
                    builder: (context, state) {
                      final orderBloc = context.read<DeliveryOrderCubit>();
                      return TabBarView(
                        controller: controller,
                        children: [
                          DeliveryOrderList(
                            pagingController: orderBloc.pagingControllerNew,
                            onReject: (p0) => context
                                .read<DeliveryActionsCubit>()
                                .rejectOrder(order: p0),
                            onAccept: (p0) => context
                                .read<DeliveryActionsCubit>()
                                .updateOrder(id: p0.id!.toInt()),
                          ),
                          DeliveryOrderList(
                            onGetDetails: (p0) => context.navigateTo(
                              TrackOrderScreen(id: p0.id ?? 0),
                            ),
                            pagingController:
                                orderBloc.pagingControllerInPrepareSupplier,
                          ),
                          BlocBuilder<
                            DeliveryLocationCubit,
                            DeliveryLocationState
                          >(
                            builder: (context, state) {
                              return DeliveryOrderList(
                                statusText:
                                    context.localizations.receiveFromSupplier,
                                pagingController:
                                    orderBloc.pagingControllerDonePrepare,
                                onChangeStatus: (p0) {
                                  context
                                      .read<DeliveryLocationCubit>()
                                      .getDriverStreamLocation(order: p0);
                                  bloc.updateOrder(
                                    id: p0.id ?? 0,
                                    status:
                                        "delivery_received_order_from_supplier",
                                  );
                                },
                                onGetDetails: (p0) => context.navigateTo(
                                  TrackOrderScreen(id: p0.id ?? 0),
                                ),
                              );
                            },
                          ),
                          DeliveryOrderList(
                            pagingController:
                                orderBloc.pagingControllerWithDelegate,
                            onChangeStatus: (p0) => bloc.updateOrder(
                              id: p0.id ?? 0,
                              status: "delivery_completed",
                            ),
                            statusText: context.localizations.deliveryToAddress,
                            onGetDetails: (p0) => context.navigateTo(
                              TrackOrderScreen(id: p0.id ?? 0),
                            ),
                          ),
                          DeliveryOrderList(
                            pagingController:
                                orderBloc.pagingControllerDelivered,
                            statusText: context.localizations.confirmed,
                            onGetDetails: (p0) => context.navigateTo(
                              TrackOrderScreen(id: p0.id ?? 0),
                            ),
                          ),
                          DeliveryOrderList(
                            statusText: context.localizations.canceled,
                            onChangeStatus: (p0) {},
                            pagingController:
                                orderBloc.pagingControllerCanceled,
                            backgroundColor: context.colorScheme.error,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _init({bool isRefresh = false}) {
    final bloc = context.read<DeliveryOrderCubit>();
    // Ensure timers are started whenever a pending order is introduced
    final actionsCubit = context.read<DeliveryActionsCubit>();
    bloc.onOrderAddedToPending = (order) {
      actionsCubit.startOrderTimer(order);
    };

    if (!isRefresh) {
      bloc.pagingControllerNew.addPageRequestListener((pageKey) {
        bloc.fetchPage(
          DeliveryParams(status: OrderType.pending, pageKey: pageKey),
          bloc.pagingControllerNew,
        );
      });
      bloc.pagingControllerInPrepareSupplier.addPageRequestListener((pageKey) {
        bloc.fetchPage(
          DeliveryParams(status: OrderType.inPreparation, pageKey: pageKey),
          bloc.pagingControllerInPrepareSupplier,
        );
      });

      bloc.pagingControllerDonePrepare.addPageRequestListener((pageKey) {
        bloc.fetchPage(
          DeliveryParams(status: OrderType.readyForDeleivery, pageKey: pageKey),
          bloc.pagingControllerDonePrepare,
        );
      });

      bloc.pagingControllerWithDelegate.addPageRequestListener((pageKey) {
        bloc.fetchPage(
          DeliveryParams(status: OrderType.outForDeleivery, pageKey: pageKey),
          bloc.pagingControllerWithDelegate,
        );
      });

      bloc.pagingControllerDelivered.addPageRequestListener((pageKey) {
        bloc.fetchPage(
          DeliveryParams(status: OrderType.delivered, pageKey: pageKey),
          bloc.pagingControllerDelivered,
        );
      });
      bloc.pagingControllerCanceled.addPageRequestListener((pageKey) {
        bloc.fetchPage(
          DeliveryParams(status: OrderType.canceled, pageKey: pageKey),
          bloc.pagingControllerCanceled,
        );
      });
    } else {
      bloc.pagingControllerNew.refresh();
      bloc.pagingControllerInPrepareSupplier.refresh();
      bloc.pagingControllerDonePrepare.refresh();
      bloc.pagingControllerWithDelegate.refresh();
      bloc.pagingControllerDelivered.refresh();
      bloc.pagingControllerCanceled.refresh();
    }
  }
}
