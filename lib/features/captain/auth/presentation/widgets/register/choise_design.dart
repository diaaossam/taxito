import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../../widgets/app_text.dart';

class ChoiceDesign extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiceDesign(
      {super.key,
      required this.label,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? context.colorScheme.primary : Colors.white,
            border: isSelected
                ? null
                : Border.all(
                    color: context.colorScheme.outline,
                  ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: AppText(
              fontWeight: FontWeight.bold,
              text: label,
              color: isSelected ? Colors.white : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
