import 'dart:async';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

class TripTimerDesign extends StatefulWidget {
  final Function(bool) callBack;

  const TripTimerDesign({super.key, required this.callBack});

  @override
  State<TripTimerDesign> createState() => _TripTimerDesignState();
}

class _TripTimerDesignState extends State<TripTimerDesign> {
  Timer? _timer;
  late int _countdown;

  @override
  void initState() {
    super.initState();
    _countdown = 60;
    startTimer();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
        text: TextSpan(
            text: "${context.localizations.rejection1} ",
            style: TextStyle(
                color: context.colorScheme.shadow,
                fontFamily: AppStrings.arabicFont,
                fontSize: 12,
                fontWeight: FontWeight.w600),
            children: [
          TextSpan(
            text: "00:${_countdown.toString()}  ",
            style: TextStyle(
                color: context.colorScheme.error,
                fontFamily: AppStrings.arabicFont,
                fontSize: 12,
                fontWeight: FontWeight.w600)
          ),
          TextSpan(
            text: context.localizations.rejection2,
          ),
        ]));
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) => setState(
        () {
          if (_countdown < 1) {
            widget.callBack(true);
            timer.cancel();
          } else {
            _countdown--;
          }
        },
      ),
    );
  }

  void resetTimer() {
    _timer!.cancel();
    _countdown = 60;
    startTimer();
  }
}
