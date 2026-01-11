import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/auth/presentation/pages/login_screen.dart';
import 'package:aslol/features/settings/presentation/widgets/app_dialog_design.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsHelper {
  Future<void> showAppDialog({
    required BuildContext context,
    String? title,
    String? acceptButton,
    String? cancelButton,
    String? image,
    double? height,
    required Function(bool) isAccept,
  }) async {
    showDialog(
      context: context,
      builder: (context) => AppDialogDesign(
        isAccept: isAccept,
        title: title,
        image: image,
        height: height,
        acceptButton: acceptButton,
        cancelButton: cancelButton,
      ),
    );
  }

  Future<void> showGuestDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: SizedBox(
                height: SizeConfig.bodyHeight * .3,
                child: Center(
                  child: Column(
                    children: [
                      20.verticalSpace,
                      AppText(
                          text: context.localizations.login,
                          fontWeight: FontWeight.bold,
                          textSize: 18,
                          color: context.colorScheme.primary),
                      SizedBox(
                        height: SizeConfig.bodyHeight * .04,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.screenWidth * .02),
                        child: AppText(
                            align: TextAlign.center,
                            maxLines: 5,
                            text: context.localizations.guestLogin,
                            color: context.colorScheme.shadow),
                      ),
                      20.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              textSize: 10,
                                height: SizeConfig.bodyHeight * .06,
                                text: context.localizations.login,
                                press: () => context
                                    .navigateTo(const LoginScreen())),
                          ),
                          5.horizontalSpace,
                          Expanded(
                            child: CustomButton(
                                textSize: 10,
                                backgroundColor: Colors.transparent,
                                height: SizeConfig.bodyHeight * .06,
                                textColor: context.colorScheme.primary,
                                text: context.localizations.back,
                                press: () {
                                  Navigator.pop(context);
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }

  static Future<void> contactUsWithWhatsApp(
      {required String phoneNumber}) async {
    var whatUrl = 'https://wa.me/$phoneNumber?text=';
    await launchUrl(Uri.parse(whatUrl), mode: LaunchMode.externalApplication);
  }

  static Future<void> contactUsWithTelegram({required String telegram}) async {
    await launchUrl(Uri.parse(telegram), mode: LaunchMode.externalApplication);
  }

  static Future<void> contactUsWithPhoneNumber(
      {required String phoneNumber}) async {
    String url = "tel://$phoneNumber";
    await launchUrl(Uri.parse(url));
  }

  static Future<void> lunchUrl({required String url}) async {
    String url = "https://www.google.com.eg/?hl=ar";
    await launchUrl(Uri.parse(url));
  }

  static Future<void> openFacebook(String facebookUrl) async {
    await launchUrl(Uri.parse(facebookUrl),
        mode: LaunchMode.externalApplication);
  }

  static Future<void> openX(String xUrl) async {
    await launchUrl(Uri.parse(xUrl), mode: LaunchMode.externalApplication);
  }

  static Future<void> openInstagram(String instagramUrl) async {
    await launchUrl(Uri.parse(instagramUrl),
        mode: LaunchMode.externalApplication);
  }

  static Future<void> openTikTok(String tikTokUrl) async {
    await launchUrl(Uri.parse(tikTokUrl), mode: LaunchMode.externalApplication);
  }

  static Future<void> openWebsite(String url) async {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
