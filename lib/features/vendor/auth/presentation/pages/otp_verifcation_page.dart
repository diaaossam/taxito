import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/dependencies/injectable_dependencies.dart';
import '../cubit/otp/otp_bloc.dart';
import '../widgets/auth_app_bar.dart';
import '../widgets/otp/otp_body.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phoneNumber;
  final bool isLogin;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    required this.isLogin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<OtpBloc>(),
      child: BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) {
          return Scaffold(
            appBar: const CustomAuthAppBar(
              showBack: true,
              isWithBackText: true,
            ),
            body: OtpVerficationWidget(
              phoneNumber: phoneNumber,
              isLogin: isLogin,
            ),
          );
        },
      ),
    );
  }
}
