import 'dart:async';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/features/auth/presentation/cubit/otp/otp_bloc.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        if(_countdown < 1) {
          return Center(
            child: InkWell(
              onTap: () {
               // context.read<OtpBloc>().add(R)
                resetTimer();
              },
              child: AppText(
                text: context.localizations.resendCode,
                color: context.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText(
                text: context.localizations.dontReceiveCode,
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w500,
              ),
              const SizedBox(
                width: 5,
              ),

              AppText(
                text: "$_countdown",
                color: context.colorScheme.shadow,
                fontWeight: FontWeight.w600,
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
    setState(() {});
  }

  void resetTimer() {
    _timer!.cancel();
    _countdown = 60;
    startTimer();
  }
}
