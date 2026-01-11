import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(Widget widget,
      {Function(dynamic)? callback,
      PageTransitionType? pageTransitionType,
      Alignment? alignment,
      Duration? duration, Widget ? childCurrent}) {
    Navigator.push(
      this,
      PageTransition(
          child: widget,
          childCurrent: childCurrent,
          type: pageTransitionType ?? PageTransitionType.leftToRight,
          duration: duration ?? const Duration(milliseconds: 100),
          alignment: alignment),
    ).then((value) {
      if (callback != null) {
        callback.call(value);
      }
    });
  }

  void navigateToAndFinish(Widget widget, {Function(dynamic)? callback}) {
    Navigator.pushAndRemoveUntil(
      this,
      PageTransition(
          child: widget,
          type: PageTransitionType.leftToRight,
          duration: const Duration(milliseconds: 100)),
      (Route<dynamic> route) => false,
    );
  }
}
