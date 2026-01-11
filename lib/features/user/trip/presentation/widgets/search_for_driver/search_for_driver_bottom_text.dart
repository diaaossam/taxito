import 'dart:async';

import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_size.dart';
import '../../../../../core/utils/app_strings.dart';

class SearchForDriverBottomText extends StatefulWidget {
  final VoidCallback callback;

  const SearchForDriverBottomText({super.key, required this.callback});

  @override
  State<SearchForDriverBottomText> createState() =>
      _SearchForDriverBottomTextState();
}

class _SearchForDriverBottomTextState extends State<SearchForDriverBottomText> {
  Timer? _timer;
  late int _countdown;
  bool _hasCallbackBeenCalled = false;

  @override
  void initState() {
    super.initState();
    _countdown = 300;
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final int minutes = _countdown ~/ 60;
    final int seconds = _countdown % 60;
    return Padding(
      padding: screenPadding(),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          children: [
            TextSpan(
                text: context.localizations.searchingForDriverBody2,
                style: mainTextStyle(context)),
            const WidgetSpan(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
            )),
            TextSpan(
                text: '$minutes:${seconds.toString().padLeft(2, '0')}',
                // نعرض الدقائق والثواني
                style: termsTextStyle(context)),
            const WidgetSpan(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
            )),
            TextSpan(
              text: context.localizations.minute,
              style: mainTextStyle(context),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle mainTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontFamily: AppStrings.arabicFont,
          overflow: TextOverflow.ellipsis,
          color: context.colorScheme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w400);

  TextStyle termsTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontFamily: AppStrings.arabicFont,
            overflow: TextOverflow.ellipsis,
            color: context.colorScheme.primary,
            fontSize: 14,
          );

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) {
        setState(() {
          if (_countdown <= 0) {
            timer.cancel();
            // Only call callback once and only when countdown reaches exactly 0
            if (!_hasCallbackBeenCalled) {
              _hasCallbackBeenCalled = true;
              widget.callback();
            }
          } else {
            _countdown--;
          }
        });
      },
    );
  }

  void resetTimer() {
    _timer?.cancel();
    _countdown = 300; // إعادة تعيين إلى 5 دقائق
    _hasCallbackBeenCalled = false; // Reset callback flag
    startTimer();
  }
}
