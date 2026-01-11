import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../../../widgets/app_text.dart';
import '../../../settings/presentation/pages/privacy_policy_screen.dart';

class TermsRegisterWidget extends StatelessWidget {
  const TermsRegisterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center();
    /* return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final bloc = context.read<RegisterCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: AppText(
                  text: context.localizations.iAgreeWith,
                  fontWeight: FontWeight.bold,
                )),
                Checkbox(
                  value: bloc.isTermsChecked,
                  onChanged: (value) => bloc.changeTermsState(),
                ),
              ],
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                      text: context.localizations.terms1,
                      style: mainTextStyle(context)),
                  const WidgetSpan(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                  )),
                  TextSpan(
                    text: context.localizations.terms,
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
                    text: context.localizations.terms2,
                    style: mainTextStyle(context),
                  ),
                  const WidgetSpan(
                      child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                  )),
                  TextSpan(
                    text: context.localizations.privacyPolicy,
                    style: termsTextStyle(context),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => context.navigateTo(
                          const PrivacyPolicyScreen(page: 2),
                          pageTransitionType: PageTransitionType.bottomToTop),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );*/
  }

  TextStyle mainTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontFamily: AppStrings.arabicFont,
          overflow: TextOverflow.ellipsis,
          color: context.colorScheme.onSurface,
          fontSize: 10,
          letterSpacing: 0.1,
          fontWeight: FontWeight.w400);

  TextStyle termsTextStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontFamily: AppStrings.arabicFont,
            overflow: TextOverflow.ellipsis,
            decoration: TextDecoration.underline,
            color: context.colorScheme.onSurface,
            letterSpacing: 0.1,
            fontSize: 10,
          );
}
