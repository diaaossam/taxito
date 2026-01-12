import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/features/user/auth/presentation/cubit/otp/otp_bloc.dart';
import 'package:taxito/features/user/auth/presentation/widgets/otp/otp_body.dart';

import '../../../../../core/enum/user_type.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;
  final UserType userType;

  const OtpVerificationScreen({
    super.key,
    required this.userType,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OtpBloc>(),
      child: Scaffold(
        appBar: CustomAppBar(title: context.localizations.verifyPhoneNumber),
        body: OtpVerficationWidget(
          userType: userType,
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }
}
