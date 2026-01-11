import 'package:flutter/material.dart';

extension NavigationExtension on PageController {
  void toNextPage() {
    nextPage(duration: const Duration(milliseconds: 600), curve: Curves.fastLinearToSlowEaseIn);
  }
  void toPreviousPage() {
    previousPage(duration: const Duration(milliseconds: 600), curve: Curves.fastLinearToSlowEaseIn);
  }
}