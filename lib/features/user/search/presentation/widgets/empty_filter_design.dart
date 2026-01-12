import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';

class EmptyFilterDesign extends StatelessWidget {
  const EmptyFilterDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.bodyHeight*.2,),
        AppImage.asset(
          Assets.images.emptySearch.path,
          height: SizeConfig.bodyHeight * .3,
        ),
        AppText(text: context.localizations.noSearchResult),
      ],
    );
  }
}
