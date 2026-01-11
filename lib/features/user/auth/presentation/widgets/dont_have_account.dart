import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/features/auth/presentation/pages/login_screen.dart';
import 'package:aslol/features/auth/presentation/pages/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DontHaveAccountWidget extends StatelessWidget {
  const DontHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => context.navigateTo(const RegisterScreen()),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: context.localizations.dontHaveAccount,
                  style: mainTextStyle(context)),
              const WidgetSpan(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 2),
              )),
              TextSpan(
                text: context.localizations.newRegister,
                style: termsTextStyle(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle mainTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontFamily: AppStrings.arabicFont,
          overflow: TextOverflow.ellipsis,
          color: context.colorScheme.shadow,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400);

  TextStyle termsTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontFamily: AppStrings.arabicFont,
            overflow: TextOverflow.ellipsis,
            color: context.colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 12.sp,
          );
}
