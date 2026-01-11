import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_text_form_field.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../data/models/orders.dart';

class OrderDetailsProduct extends StatefulWidget {
  final Orders orders;
  final Function(Map<String, dynamic>)? ratingResponse;

  const OrderDetailsProduct({
    super.key,
    required this.orders,
    this.ratingResponse,
  });

  @override
  State<OrderDetailsProduct> createState() => _OrderDetailsProductState();
}

class _OrderDetailsProductState extends State<OrderDetailsProduct> {
  final Map<int, Map<String, dynamic>> _ratingsData = {};

  void _updateResponse() {
    final response = {
      "rate_type": "product",
      "data": _ratingsData.values.toList(),
      "id":widget.orders.id,
    };
    widget.ratingResponse?.call(response);
  }

  @override
  Widget build(BuildContext context) {
    final bool isRating = widget.ratingResponse != null;

    return Container(
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.bodyHeight*.02,),
          ...List.generate(
            (widget.orders.items ?? []).length, (index) {
              final item = (widget.orders.items ?? [])[index];
              final productId = item.product?.id;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        if (!isRating) ...[
                          AppText(
                            text: "${item.qty.toString()}X",
                            textSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                          10.horizontalSpace,
                        ],
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AppImage.network(
                            remoteImage: item.product?.images?.first.url,
                            height: isRating
                                ? SizeConfig.bodyHeight * .14
                                : SizeConfig.bodyHeight * .1,
                            width: isRating
                                ? SizeConfig.bodyHeight * .14
                                : SizeConfig.bodyHeight * .1,
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
                                      remoteImage: widget.orders.supplier?.logo,
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
                              if (isRating) ...[
                                FormBuilderField<double>(
                                  name: "rating$productId",
                                  builder: (field) => RatingBar.builder(
                                    initialRating: 5,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: false,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) =>
                                        AppImage.asset(Assets.icons.star),
                                    onRatingUpdate: (value) {
                                      if (productId != null) {
                                        _ratingsData[productId.toInt()] = {
                                          "product_id": productId,
                                          "rating": value.toInt().toString(),
                                          "comment": _ratingsData[productId]?["comment"] ?? "",
                                        };
                                        _updateResponse();
                                      }
                                    },
                                  ),
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                    if(isRating)...[
                      15.verticalSpace,
                      CustomTextFormField(
                        name: "product$productId",
                        hintText:
                        context.localizations.enterYouRating,
                        onChanged: (val) {
                          if (productId != null) {
                            _ratingsData[productId.toInt()] = {
                              "product_id": productId,
                              "rating": _ratingsData[productId]?["rating"] ?? 5,
                              "comment": val,
                            };
                            _updateResponse();
                          }
                        },
                      ),
                    ]

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
