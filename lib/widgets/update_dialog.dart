import 'dart:io';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool?> showUpdateDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.system_update,
                color: context.colorScheme.primary, size: 28),
            const SizedBox(width: 8),
            Text(
              context.localizations.updateTitle,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              context.localizations.updateBody,
              style: const TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.star, color: context.colorScheme.primary, size: 20),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    context.localizations.updateBody1,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.bug_report,
                    color: context.colorScheme.primary, size: 20),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    context.localizations.updateBody2,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () async {
              const androidUrl = 'https://play.google.com/store/apps/details?id=co.uk.jacksi.taxito_driver';
              const iosUrl = 'https://apps.apple.com/app/id6754820055';
              final url = Platform.isAndroid ? androidUrl : iosUrl;
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url),
                    mode: LaunchMode.externalApplication);
              } else {
                print('Could not launch store URL');
              }
            },
            icon: Icon(Icons.open_in_new),
            label: Text(
              context.localizations.updateBody3,
              style: TextStyle(color: Colors.white,fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
