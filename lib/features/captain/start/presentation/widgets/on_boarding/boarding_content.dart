import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/utils/app_size.dart';

class BoardingContent extends StatelessWidget {
  const BoardingContent({
    super.key,
    required this.text,
    required this.image,
    required this.title,
  });

  final String text, image, title;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: SizeConfig.bodyHeight * .06,
          ),
          Padding(
            padding: screenPadding(),
            child: AppText(
              text: title,
              align: TextAlign.center,
              fontWeight: FontWeight.w600,
              textSize: 26,
            ),
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          Padding(
            padding: screenPadding(),
            child: AppText.hint(
              text: text,
              align: TextAlign.start,
              fontWeight: FontWeight.w400,
              maxLines: 3,
              textSize: 14,
            ),
          ),
          const Spacer(),
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: SizeConfig.bodyHeight * .8,
          ),
        ],
      ),
    );
  }
}
