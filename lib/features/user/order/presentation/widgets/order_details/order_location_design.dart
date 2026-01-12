import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../captain/delivery_order/data/models/response/my_address.dart';

class OrderLocationDesign extends StatelessWidget {
  final MyAddress address;

  const OrderLocationDesign({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * .03,
        vertical: SizeConfig.bodyHeight * .02,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: context.colorScheme.surface,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: context.localizations.address1,
            fontWeight: FontWeight.w600,
            textSize: 14,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          AppText(
            text: address.notes ?? address.address ?? "",
            textSize: 11,
            maxLines: 2,
            color: context.colorScheme.shadow,
          ),
        ],
      ),
    );
  }
}
