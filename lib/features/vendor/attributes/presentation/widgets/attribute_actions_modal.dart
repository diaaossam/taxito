import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttributeActionsModal extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final String? titleDelete, titleUpdate;

  const AttributeActionsModal({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.titleDelete,
    this.titleUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: const CloseButton(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                // Edit button
                CustomButton(
                    text: titleUpdate ?? context.localizations.editAttribute,
                    press: () {
                      Navigator.pop(context);
                      onEdit();
                    }),
                SizedBox(height: 12.h),

                CustomButton(
                  text: titleDelete ?? context.localizations.deleteAttribute,
                  press: () {
                    Navigator.pop(context);
                    onDelete();
                  },
                  backgroundColor: Colors.transparent,
                  textColor: context.colorScheme.error,
                  borderColor: context.colorScheme.error,
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
