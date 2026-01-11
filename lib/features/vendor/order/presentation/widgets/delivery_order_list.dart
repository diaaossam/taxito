import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../data/models/response/orders.dart';
import 'order_item_design.dart';

class DeliveryOrderList extends StatelessWidget {
  final PagingController<int, Orders> pagingController;
  final Function(Orders)? onReject;
  final Function(Orders)? onAccept;
  final Function(Orders)? onGetDetails;
  final Function(Orders)? onChangeStatus;
  final String? statusText;
  final Color? backgroundColor;

  const DeliveryOrderList(
      {super.key,
      required this.pagingController,
      this.onReject,
      this.onAccept,
      this.backgroundColor,
      this.onGetDetails,
      this.onChangeStatus,
      this.statusText});

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, Orders>(
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          noItemsFoundIndicatorBuilder: (context) =>
              _buildNoOrderFound(context),
          itemBuilder: (context, Orders item, index) => OrderItemDesign(
              isLoading: false,
              orders: item,
              onAccept: onAccept,
              onReject: onReject,
              backgroundColor: backgroundColor,
              onChangeStatus: onChangeStatus,
              statusText: statusText,
              onGetDetails: onGetDetails),
        ));
  }

  Widget _buildNoOrderFound(BuildContext context) {
    return Opacity(
      opacity: 0.4,
      child: Column(
        children: [
          SizedBox(
            height: SizeConfig.bodyHeight * .2,
          ),
          AppImage.asset(
            Assets.icons.myOrders,
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: SizeConfig.bodyHeight * .02,
          ),
          AppText(
            text: context.localizations.noOrders,
            color: context.colorScheme.shadow,
            fontWeight: FontWeight.w600,
            textSize: 17,
          )
        ],
      ),
    );
  }
}
