import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/settings_bloc.dart';

class CopyWriteWidget extends StatelessWidget {
  final Color? color;

  const CopyWriteWidget({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: context.read<SettingsBloc>().settingsModel?.showCopyright == true,
      child: InkWell(
        onTap: () async => launchUrl(Uri.parse("https://jacksi.co.uk/")),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: context.localizations.copyWrite1,
                  color: color,
                  textSize: 10,
                ),
                5.horizontalSpace,
                AppImage.asset(
                  Assets.icons.heart2,
                  color: context.colorScheme.primary,
                ),
                5.horizontalSpace,
                AppText(
                  text: context.localizations.copyWrite2,
                  textDecoration: TextDecoration.underline,
                  color: color,
                  textSize: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
