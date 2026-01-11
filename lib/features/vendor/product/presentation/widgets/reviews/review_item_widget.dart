import 'package:flutter/material.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/vendor/product/data/models/response/review_model.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/image_picker/app_image.dart';

class ReviewItemWidget extends StatelessWidget {
  final ReviewModel review;

  const ReviewItemWidget({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SizeConfig.screenWidth * .04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: review.user?.name ?? "",
                      fontWeight: FontWeight.bold,
                      textSize: 14,
                    ),
                    const SizedBox(height: 4),
                    RatingBar.builder(
                      initialRating: review.rating!.toDouble(),
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      ignoreGestures: true,
                      itemCount: 5,
                      itemSize: 20,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) =>
                          AppImage.asset(Assets.icons.star),
                      onRatingUpdate: (value) {},
                    ),
                  ],
                ),
              ),

              // صورة المستخدم
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
                child: ClipOval(
                  child: Image.network(
                    review.user!.image!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.person,
                        color: Colors.grey[600],
                        size: 20,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // نص التقييم
          AppText(
            text: review.comment ?? '',
            textSize: 14,
            color: Colors.grey[700],
            maxLines: null,
          ),

          const SizedBox(height: 8),

          // الوقت
          AppText(
            text: review.createdAt.toString(),
            textSize: 12,
            color: Colors.grey[500],
          ),
        ],
      ),
    );
  }
}
