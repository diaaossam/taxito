import 'package:another_flushbar/flushbar.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/features/captain/start/presentation/pages/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taxito/config/theme/color_scheme.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/app_text.dart';

class AppConstant {
  static Future<void> showCustomSnakeBar(
      BuildContext context, msg, isSuccess) async {
    if (msg != "" && msg != null) {
      Flushbar(
        message: msg,
        messageSize: 13,
        icon: isSuccess
            ? const Icon(
                Icons.check,
                size: 28.0,
                color: Colors.green,
              )
            : Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.red)),
                child: const Icon(
                  Icons.close,
                  size: 28.0,
                  color: Colors.red,
                ),
              ),
        margin: const EdgeInsets.all(8),
        flushbarStyle: FlushbarStyle.GROUNDED,
        borderRadius: BorderRadius.circular(8),
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        leftBarIndicatorColor: context.colorScheme.primary,
      ).show(context);
    }
  }

  static void showToast(
      {required String msg, Color? color, ToastGravity? gravity}) {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: msg,
        backgroundColor: color ?? AppColorScheme.light.primary,
        gravity: gravity ?? ToastGravity.BOTTOM);
  }

  static void showSnackBar(BuildContext context, String errorMsg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(errorMsg),
      backgroundColor: Colors.black,
      duration: const Duration(seconds: 5),
    ));
  }

  Future<void> showAuthDialog({required BuildContext context}) async {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        content: AppText(
          text: context.localizations.sessionExpired,
          maxLines: 4,
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            isDestructiveAction: true,
            child: AppText(
                text: context.localizations.logout,
                textSize: 14,
                maxLines: 4,
                textHeight: 1.8,
                fontWeight: FontWeight.bold,
                color: Colors.red),
            onPressed: () async => context.navigateTo(const WelcomeScreen()),
          ),
        ],
      ),
    );
  }
}
