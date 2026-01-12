import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/captain/auth/presentation/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlreadyHaveAccountWidget extends StatelessWidget {
  const AlreadyHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () =>
            context.navigateTo(const LoginScreen(userType: UserType.user)),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: context.localizations.alreadyHaveAccount,
                style: mainTextStyle(context),
              ),
              const WidgetSpan(
                child: Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
              ),
              TextSpan(
                text: context.localizations.login,
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
        fontWeight: FontWeight.w400,
      );

  TextStyle termsTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontFamily: AppStrings.arabicFont,
        overflow: TextOverflow.ellipsis,
        color: context.colorScheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 12.sp,
      );
}
