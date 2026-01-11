import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/app_strings.dart';
import 'package:aslol/features/settings/presentation/pages/privacy_policy_screen.dart';
import 'package:page_transition/page_transition.dart';

class TermsRegisterWidget extends StatefulWidget {
  const TermsRegisterWidget({super.key});

  @override
  State<TermsRegisterWidget> createState() => _TermsRegisterWidgetState();
}

class _TermsRegisterWidgetState extends State<TermsRegisterWidget> {
  bool isCheckedBox = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: isCheckedBox,
            onChanged: (value) => setState(() => isCheckedBox = !isCheckedBox)),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                    text: context.localizations.iAgreeWith,
                    style: mainTextStyle(context)),
                const WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                )),
                TextSpan(
                  text: context.localizations.privacyPolicy,
                  style: termsTextStyle(context),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.navigateTo(const PrivacyPolicyScreen(page: 3),
                          pageTransitionType: PageTransitionType.bottomToTop);
                    },
                ),
                const WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                )),
                TextSpan(
                  text: context.localizations.and,
                  style: mainTextStyle(context),
                ),
                const WidgetSpan(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2),
                )),
                TextSpan(
                  text: context.localizations.termsAndConditions,
                  style: termsTextStyle(context),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => context.navigateTo(
                        const PrivacyPolicyScreen(page: 2),
                        pageTransitionType: PageTransitionType.bottomToTop),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  TextStyle mainTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontFamily: AppStrings.arabicFont,
          overflow: TextOverflow.ellipsis,
          color: context.colorScheme.onSurface,
          fontSize: 16,
          fontWeight: FontWeight.w400);

  TextStyle termsTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontFamily: AppStrings.arabicFont,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600,
            color: context.colorScheme.primary,
            fontSize: 16,
          );
}
