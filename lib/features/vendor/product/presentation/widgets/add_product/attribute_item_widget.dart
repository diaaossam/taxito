import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/vendor/attributes/data/models/attribute_model.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';

class AttributeItemWidget extends StatelessWidget {
  final AttributeModel attribute;
  final bool isSelected;
  final VoidCallback onTap;

  const AttributeItemWidget({
    super.key,
    required this.attribute,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: SizeConfig.screenWidth * 0.04,
        vertical: SizeConfig.bodyHeight * 0.01,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: AppText(
              text: attribute.titleAr ?? attribute.title ?? '',
              textSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.orange : Colors.grey[400]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
