import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/core/data/models/orders.dart';
import 'package:flutter/material.dart';
import '../../../../../../widgets/app_text.dart';
import 'order_details_product.dart';
import 'order_info_card.dart';
import 'order_location_design.dart';
import 'order_price_details.dart';

class OrderDetailsBody extends StatelessWidget {
  final Orders orders;

  const OrderDetailsBody({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: SizeConfig.bodyHeight * .02),
        OrderInfoCard(orders: orders),
        SizedBox(height: SizeConfig.bodyHeight * .01),
        Padding(
          padding: screenPadding(),
          child: AppText(
            text: context.localizations.orderDetails,
            fontWeight: FontWeight.w600,
            textSize: 14,
          ),
        ),
        SizedBox(height: SizeConfig.bodyHeight * .01),
        OrderDetailsProduct(orders: orders),
        SizedBox(height: SizeConfig.bodyHeight * .01),
        OrderLocationDesign(address: orders.address!),
        SizedBox(height: SizeConfig.bodyHeight * .01),
        //PaymentTypeOrder(orders: orders,),
        SizedBox(height: SizeConfig.bodyHeight * .01),
        PaymentPriceOrder(orders: orders),
      ],
    );
  }
}
