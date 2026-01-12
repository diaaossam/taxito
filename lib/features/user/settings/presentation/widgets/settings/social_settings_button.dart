import 'package:flutter/material.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';

class SocialSettingsButton extends StatelessWidget {
  final String icon;
  final VoidCallback press;

  const SocialSettingsButton(
      {super.key, required this.icon, required this.press});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: press,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.colorScheme.outline)),
            child: AppImage.asset(icon)),
      ),
    );
  }
}
