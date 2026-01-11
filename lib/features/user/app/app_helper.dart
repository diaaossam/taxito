

import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppHelper {
  Future<void> showAppDailog({
    required BuildContext context,
    required Widget child,
  }) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            child,
            Positioned(
              top: 0,
              left: 16,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36.h,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(color: context.colorScheme.primary),
                  ),
                  child: const Icon(Icons.close, size: 20),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
