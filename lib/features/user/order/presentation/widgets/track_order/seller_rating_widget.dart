import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../../../widgets/image_picker/app_image.dart';
import '../../../data/models/orders.dart';

class SellerRatingWidget extends StatefulWidget {
  final Orders orders;
  final Function(Map<String, dynamic>) ratingResponse;

  const SellerRatingWidget({
    super.key,
    required this.orders,
    required this.ratingResponse,
  });

  @override
  State<SellerRatingWidget> createState() => _SellerRatingWidgetState();
}

class _SellerRatingWidgetState extends State<SellerRatingWidget> {
  double? _currentRating;
  String? _currentNote;

  void _updateResponse({num? rating, String? note}) {
    if (rating != null) _currentRating = rating.toDouble();
    if (note != null) _currentNote = note;

    final response = {
      "rate_type": "supplier",
      if (_currentNote != null && _currentNote!.isNotEmpty)
        "review": _currentNote,
      if (_currentRating != null) "rating": _currentRating.toString(),
      "id": widget.orders.id,
    };
    widget.ratingResponse(response);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colorScheme.surface),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.bodyHeight * .04),
          AppText(
            text: context.localizations.rateSellerBody,
            fontWeight: FontWeight.bold,
            textSize: 14,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AppImage.network(
                  remoteImage: widget.orders.supplier?.logo,
                  height: SizeConfig.bodyHeight * .14,
                  width: SizeConfig.bodyHeight * .14,
                  fit: BoxFit.cover,
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    AppText(
                      text: widget.orders.supplier?.name ?? "",
                      fontWeight: FontWeight.w600,
                      textSize: 12,
                    ),
                    20.verticalSpace,
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: AppText.hint(
                        text: "${widget.orders.supplier?.phone}",
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    20.verticalSpace,
                    FormBuilderField<double>(
                      name: "rating",
                      builder: (field) => RatingBar.builder(
                        initialRating: 5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                        ),
                        itemBuilder: (context, _) =>
                            AppImage.asset(Assets.icons.star),
                        onRatingUpdate: (value) {
                          _updateResponse(rating: value, note: _currentNote);
                        },
                      ),
                    ),
                    15.verticalSpace,
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          CustomTextFormField(
            name: "note",
            hintText: context.localizations.enterYouRating,
            onChanged: (val) {
              _updateResponse(rating: _currentRating ?? 5, note: val);
            },
          ),
        ],
      ),
    );
  }
}
