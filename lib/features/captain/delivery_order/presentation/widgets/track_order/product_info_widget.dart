import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../data/models/response/orders.dart';

class OrderDetailsProduct extends StatefulWidget {
  final Orders orders;

  const OrderDetailsProduct({
    super.key,
    required this.orders,
  });

  @override
  State<OrderDetailsProduct> createState() => _OrderDetailsProductState();
}

class _OrderDetailsProductState extends State<OrderDetailsProduct> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.bodyHeight * .02,
          ),
          CustomButton(
            height: 40.h,
              textColor: context.colorScheme.onSurface,
              backgroundColor:Colors.transparent,
              text:showDetails ?context.localizations.hideOrderDetails :"${context.localizations.showOrderDetails}  (${widget.orders.items?.length})",
              press: () => setState(() {
                    showDetails = !showDetails;
                  })),
          SizedBox(
            height: SizeConfig.bodyHeight * .02,
          ),
          if(showDetails)
          ...List.generate(
            (widget.orders.items ?? []).length,
            (index) {
              final item = (widget.orders.items ?? [])[index];
              final productId = item.product?.id;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: [
                    AppText(
                      text: "${item.qty.toString()}X",
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                    10.horizontalSpace,
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: AppImage.network(
                        remoteImage: item.product?.images?.first.url,
                        height: SizeConfig.bodyHeight * .1,
                        width: SizeConfig.bodyHeight * .1,
                        fit: BoxFit.cover,
                      ),
                    ),
                    10.horizontalSpace,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: item.product?.title ?? "",
                            fontWeight: FontWeight.w600,
                            textSize: 12,
                          ),
                          10.verticalSpace,
                          AppText.hint(
                            text:
                                "${item.price.toString()} ${context.localizations.iqd}",
                            fontWeight: FontWeight.w600,
                          ),
                          10.verticalSpace,
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: AppImage.network(
                                  width: SizeConfig.bodyHeight * .035,
                                  height: SizeConfig.bodyHeight * .035,
                                  fit: BoxFit.cover,
                                  remoteImage:
                                      widget.orders.supplier?.profileImage,
                                ),
                              ),
                              7.horizontalSpace,
                              AppText(
                                text: widget.orders.supplier?.name ?? "",
                                textSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          10.verticalSpace,
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
        ],
      ),
    );
  }
}
