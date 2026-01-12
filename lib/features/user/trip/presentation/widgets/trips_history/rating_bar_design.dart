import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/image_picker/app_image.dart';

class RatingBarDesign extends StatelessWidget {
  final num rating;

  const RatingBarDesign({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: rating.toDouble(),
      direction: Axis.horizontal,
      allowHalfRating: false,
      glow: true,
      glowColor: Colors.amber,
      itemSize: 15,
      itemCount: 5,
      ignoreGestures: true,
      ratingWidget: RatingWidget(
        half: const Center(),
        full: AppImage.asset(Assets.icons.star),
        empty: AppImage.asset(Assets.icons.emptyStar),
      ),
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      onRatingUpdate: (rating) {},
    );
  }
}
