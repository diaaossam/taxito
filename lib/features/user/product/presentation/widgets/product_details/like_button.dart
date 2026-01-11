import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

class LikeButtonDesign extends StatelessWidget {
  final Function(bool) onTapped;
  final bool isLiked;
  final double? size;
  final double? padding;
  final bool showBorder;
  final List<BoxShadow>? boxShadow;

  const LikeButtonDesign(
      {super.key,
      required this.onTapped,
      required this.isLiked,
      this.size,
      this.padding,
      this.showBorder = false,
      this.boxShadow});

  @override
  Widget build(BuildContext context) {
    return LikeButton(
      size: size ?? 33,
      onTap: _onTapped,
      isLiked: isLiked,
      circleColor: const CircleColor(start: Colors.red, end: Colors.red),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.red,
        dotSecondaryColor: Colors.black,
      ),
      likeBuilder: (bool isLiked) {
        return Container(
            padding: EdgeInsets.all(padding ?? 6),
            decoration: BoxDecoration(
                border: showBorder
                    ? Border.all(color: context.colorScheme.outline)
                    : null,
                boxShadow: boxShadow,
                shape: BoxShape.circle,
                color: Colors.white),
            child: AppImage.asset(
              isLiked ? Assets.icons.heartFilled : Assets.icons.heart,
            ));
      },
    );
  }

  Future<bool?> _onTapped(bool isLiked) async {
    onTapped(!isLiked);
    return !isLiked;
  }
}
