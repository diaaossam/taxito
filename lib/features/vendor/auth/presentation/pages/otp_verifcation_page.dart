import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/core/enum/user_type.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../captain/auth/presentation/cubit/otp/otp_bloc.dart';
import '../../../../captain/auth/presentation/widgets/auth_app_bar.dart';
import '../../../../captain/auth/presentation/widgets/otp/otp_body.dart';


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
              isLogin: isLogin, userType: UserType.supplier,
            ),
          );
        },
      ),
    );
  }
}
