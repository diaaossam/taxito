import 'package:taxito/core/enum/order_type.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/core/data/models/orders.dart';
import 'package:taxito/features/user/order/order_helper.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/generated/l10n.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timelines_plus/timelines_plus.dart';

class OrderTrackingWidget extends StatefulWidget {
  final int currentStep;
  final Orders orders;

  const OrderTrackingWidget(
      {super.key, required this.currentStep, required this.orders});

  @override
  State<OrderTrackingWidget> createState() => _OrderTrackingWidgetState();
}

class _OrderTrackingWidgetState extends State<OrderTrackingWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          nodePosition: 0,
        ),
        verticalDirection: VerticalDirection.down,
        builder: TimelineTileBuilder.connected(
          itemCount: steps.length,
          contentsAlign: ContentsAlign.basic,
          addAutomaticKeepAlives: true,
          connectorBuilder: (context, index, type) {
            final isCompleted = steps[index]["isCompleted"] as bool;
            return SolidLineConnector(
              color: isCompleted
                  ? context.colorScheme.primary
                  : context.colorScheme.shadow,
            );
          },
          indicatorBuilder: (context, index) {
            final isCompleted = steps[index]["isCompleted"] as bool;
            return DotIndicator(
              color: isCompleted ? Colors.orange : Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Icon(
                  isCompleted ? Icons.check : Icons.circle,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            );
          },
          contentsBuilder: (context, index) {
            final step = steps[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: SizeConfig.bodyHeight * .02,
                        ),
                        AppText(
                          text: step["title"] as String,
                          fontWeight: FontWeight.w600,
                          color: step["isCompleted"] as bool
                              ? Colors.black
                              : Colors.grey,
                        ),
                        if ((step["subtitle"] as String).isNotEmpty) ...[
                          8.verticalSpace,
                          AppText(
                            text: step["subtitle"] as String,
                            color: context.colorScheme.shadow,
                          ),
                        ],
                        if (step["time"] != null) ...[
                          8.verticalSpace,
                          AppText(
                            text: OrderHelper().formatDateTime(step["time"]),
                            color: context.colorScheme.shadow,
                          ),
                        ],
                        SizedBox(
                          height: SizeConfig.bodyHeight * .03,
                        ),
                      ],
                    ),
                  ),
                  AppImage.asset(
                    step['image'].toString(),
                    height: 30,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> steps = [];

  @override
  void initState() {
    List<StatusLogs>? status = widget.orders.statusLogs;
    steps = [
      {
        "title": S.current.pendingTitle,
        "subtitle": S.current.pendingBody,
        "time": status
            ?.firstWhereOrNull((element) => element.status == OrderType.pending)
            ?.createdAt,
        "isCompleted": widget.orders.status == OrderType.pending ||
            widget.orders.status == OrderType.confirmed ||
            widget.orders.status == OrderType.inPreparation ||
            widget.orders.status == OrderType.readyForDeleivery ||
            widget.orders.status == OrderType.outForDeleivery ||
            widget.orders.status == OrderType.delivered,
        "image": Assets.images.pending.path
      },
      {
        "title": S.current.confirmedTitle,
        "subtitle": S.current.confirmedBody,
        "time": status
            ?.firstWhereOrNull(
                (element) => element.status == OrderType.confirmed)
            ?.createdAt,
        "isCompleted": widget.orders.status == OrderType.confirmed ||
            widget.orders.status == OrderType.inPreparation ||
            widget.orders.status == OrderType.readyForDeleivery ||
            widget.orders.status == OrderType.outForDeleivery ||
            widget.orders.status == OrderType.delivered,
        "image": Assets.images.confirmed.path
      },
      {
        "title": S.current.inPreparation,
        "subtitle": S.current.inPrepareBody,
        "time": status
            ?.firstWhereOrNull(
                (element) => element.status == OrderType.inPreparation)
            ?.createdAt,
        "isCompleted": widget.orders.status == OrderType.inPreparation ||
            widget.orders.status == OrderType.readyForDeleivery ||
            widget.orders.status == OrderType.outForDeleivery ||
            widget.orders.status == OrderType.delivered,
        "image": Assets.images.confirmed.path
      },
      {
        "title": S.current.orderDonePrepare,
        "subtitle": S.current.donePrepareBody,
        "time": status
            ?.firstWhereOrNull(
                (element) => element.status == OrderType.inPreparation)
            ?.createdAt,
        "isCompleted": widget.orders.status == OrderType.readyForDeleivery ||
            widget.orders.status == OrderType.outForDeleivery ||
            widget.orders.status == OrderType.delivered,
        "image": Assets.images.confirmed.path
      },
      {
        "title": S.current.outForDelivery1,
        "subtitle": "",
        "time": status
            ?.firstWhereOrNull(
                (element) => element.status == OrderType.outForDeleivery)
            ?.createdAt,
        "isCompleted": widget.orders.status == OrderType.outForDeleivery ||
            widget.orders.status == OrderType.delivered,
        "image": Assets.images.outForDeleivery.path
      },
      {
        "title": S.current.deleiverd,
        "subtitle": "",
        "time": status
            ?.firstWhereOrNull(
                (element) => element.status == OrderType.delivered)
            ?.createdAt,
        "isCompleted": widget.orders.status == OrderType.delivered,
        "image": Assets.images.deleivered.path
      },
    ];
    super.initState();
  }
}
