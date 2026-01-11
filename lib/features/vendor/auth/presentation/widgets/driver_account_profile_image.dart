import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../core/extensions/app_localizations_extension.dart';
import '../../../../../core/extensions/color_extensions.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../../../widgets/image_picker/media_form_field.dart';
import '../../../../../widgets/image_picker/pick_image_sheet.dart';

class DriverAccountProfileImage extends StatelessWidget {
  final Function(File) onProfileReceived;
  final Function(File) onCoverReceived;
  final String? initialImage;
  final String? initialCover;

  const DriverAccountProfileImage(
      {super.key,
      required this.onCoverReceived,
      required this.onProfileReceived,
      this.initialImage,
      this.initialCover});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () async {
            await showMaterialModalBottomSheet(
              context: context,
              builder: (context) => PickMediaFileSheet(
                mediaType: MediaType.image,
                onPickFile: (file, thumbnail) => onCoverReceived(file),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: SizeConfig.bodyHeight * .2,
            decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.primary),
                color: context.colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(12)),
            child: initialCover != null && initialCover!.isNotEmpty
                ? initialCover!.contains("http")
                    ? AppImage.network(
                        fit: BoxFit.cover,
                        remoteImage: initialCover,
                      )
                    : AppImage.file(
                        initialCover!,
                        fit: BoxFit.cover,
                      )
                : Center(
                    child:
                        AppText(text: context.localizations.photoValidation)),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.only(top: SizeConfig.bodyHeight * .13),
            child: MediaFormField(
              defaultImage: AppImage.asset(Assets.icons.camera),
              height: SizeConfig.screenWidth * .25,
              width: SizeConfig.screenWidth * .25,
              onDataReceived: onProfileReceived,
              initialImage: initialImage,
            ),
          ),
        ),
      ],
    );
  }
}
