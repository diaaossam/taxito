import 'dart:async';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../widgets/app_text.dart';
import '../../cubit/otp/otp_bloc.dart';

class OtpTimerDesign extends StatefulWidget {
  final String phoneNumber;

  const OtpTimerDesign({super.key, required this.phoneNumber});

  @override
  State<OtpTimerDesign> createState() => _OtpTimerDesignState();
}

class _OtpTimerDesignState extends State<OtpTimerDesign> {
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
    return BlocBuilder<OtpBloc, OtpState>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text:
                        "${context.localizations.youCanRequest} ${_countdown.toString()}",
                    color: context.colorScheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  AppText(
                    text: context.localizations.second,
                    color: context.colorScheme.tertiary,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              10.verticalSpace,
              if (_countdown == 0)
                InkWell(
                  onTap: () {
                    resetTimer();
                    context
                        .read<OtpBloc>()
                        .add(ResendOtpCodeEvent(phone: widget.phoneNumber));
                  },
                  child: AppText(
                    text: context.localizations.resendCode,
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    textDecoration: TextDecoration.underline,
                  ),
                )
            ],
          ),
        );
      },
    );
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (Timer timer) => setState(
        () {
          if (_countdown < 1) {
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
