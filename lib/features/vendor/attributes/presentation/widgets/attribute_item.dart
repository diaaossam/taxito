import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/attribute_model.dart';

class AttributeItem extends StatelessWidget {
  final AttributeModel attribute;
  final VoidCallback onTap;

  const AttributeItem({
    super.key,
    required this.attribute,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.h),
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8 ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
       border: Border.all(color: context.colorScheme.onSurface.withValues(alpha: 0.5))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppText(
            text: context.localizations.attributeName,
            textSize: 11,
            fontWeight: FontWeight.w600,
          ),
          AppText(text: attribute.title??"",fontWeight: FontWeight.w600,),
          IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.more_horiz_outlined))
        ],
      ),
    );
  }
}
