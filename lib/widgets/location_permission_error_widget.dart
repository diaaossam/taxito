import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_settings_plus/open_settings_plus.dart';
import '../core/extensions/app_localizations_extension.dart';
import '../core/extensions/color_extensions.dart';
import '../core/utils/app_size.dart';
import 'app_text.dart';
import 'custom_button.dart';

enum LocationErrorType { permissionDenied, serviceDisabled }

class LocationPermissionErrorWidget extends StatelessWidget {
  final LocationErrorType errorType;
  final VoidCallback? onRetry;

  const LocationPermissionErrorWidget({
    super.key,
    required this.errorType,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConfig.bodyHeight * .04),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: SizeConfig.bodyHeight * .1),
            // Icon Container with Background
            Container(
              width: SizeConfig.screenWidth * .35,
              height: SizeConfig.screenWidth * .35,
              decoration: BoxDecoration(
                color: context.colorScheme.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                errorType == LocationErrorType.permissionDenied
                    ? Icons.location_off_outlined
                    : Icons.gps_off_outlined,
                size: SizeConfig.screenWidth * .18,
                color: context.colorScheme.primary,
              ),
            ),
            SizedBox(height: SizeConfig.bodyHeight * .04),
            // Title
            AppText(
              text: errorType == LocationErrorType.permissionDenied
                  ? context.localizations.locationPermissionDeniedTitle
                  : context.localizations.locationServiceDisabledTitle,
              textSize: 18,
              fontWeight: FontWeight.bold,
              align: TextAlign.center,
              maxLines: 3,
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            // Description
            AppText.hint(
              text: errorType == LocationErrorType.permissionDenied
                  ? context.localizations.locationPermissionDeniedBody
                  : context.localizations.locationServiceDisabledBody,
              textSize: 13,
              maxLines: 10,
              align: TextAlign.center,
            ),
            SizedBox(height: SizeConfig.bodyHeight * .04),
            // Steps Card
            Container(
              padding: EdgeInsets.all(SizeConfig.bodyHeight * .025),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest.withOpacity(
                  0.3,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: context.colorScheme.primary.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: context.colorScheme.primary,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      AppText(
                        text: context.localizations.howToFix,
                        textSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: SizeConfig.bodyHeight * .02),
                  ...(_getSteps(context).asMap().entries.map((entry) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: AppText(
                                text: "${entry.key + 1}",
                                textSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: AppText(
                              text: entry.value,
                              textSize: 13,
                              maxLines: 5,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList()),
                ],
              ),
            ),
            const Spacer(),
            // Open Settings Button
            CustomButton(
              text: context.localizations.openSettings,
              press: () async {
                if (errorType == LocationErrorType.permissionDenied) {
                  // Open app settings for permission
                  if (Platform.isAndroid) {
                    await const OpenSettingsPlusAndroid().appSettings();
                  } else {
                    await const OpenSettingsPlusIOS().appSettings();
                  }
                } else {
                  // Open location settings
                  if (Platform.isAndroid) {
                    await const OpenSettingsPlusAndroid().locationSource();
                  } else {
                    await const OpenSettingsPlusIOS().locationServices();
                  }
                }
              },
              backgroundColor: context.colorScheme.primary,
              textColor: Colors.white,
            ),
            SizedBox(height: SizeConfig.bodyHeight * .02),
            // Retry Button
            if (onRetry != null)
              CustomButton(
                text: context.localizations.tryAgain,
                press: onRetry!,
                backgroundColor: Colors.transparent,
                borderColor: context.colorScheme.primary,
                textColor: context.colorScheme.primary,
              ),
            SizedBox(height: SizeConfig.bodyHeight * .04),
          ],
        ),
      ),
    );
  }

  List<String> _getSteps(BuildContext context) {
    if (errorType == LocationErrorType.permissionDenied) {
      return [
        context.localizations.locationPermissionStep1,
        context.localizations.locationPermissionStep2,
        context.localizations.locationPermissionStep3,
      ];
    } else {
      return [
        context.localizations.locationServiceStep1,
        context.localizations.locationServiceStep2,
        context.localizations.locationServiceStep3,
      ];
    }
  }
}
