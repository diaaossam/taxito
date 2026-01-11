import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxito/config/helper/secure_file_picker.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';
import '../app_text.dart';
import 'media_form_field.dart';

class PickMediaFileSheet extends StatefulWidget {
  final MediaType mediaType;

  const PickMediaFileSheet({
    super.key,
    this.mediaType = MediaType.image,
    this.onPickFile,
  });

  final Function(File file, File? thumpNail)? onPickFile;

  @override
  State<PickMediaFileSheet> createState() => _PickMediaFileSheetState();
}

class _PickMediaFileSheetState extends State<PickMediaFileSheet> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.bodyHeight * .27,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final File? file;
              File? thumbnail;
              file = await SecureFilePicker.pickImage(
                context: context,
                ImageSource.camera,
              );
              if (mounted && file != null) {
                Navigator.pop(context, file);
                widget.onPickFile?.call(file, thumbnail);
              }
            },
            child: const ImageSheetButton(isCamera: true),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final File? file;
              File? thumbnail;
              file = await SecureFilePicker.pickImage(
                context: context,
                ImageSource.gallery,
              );
              Navigator.pop(context, file);
              if (file != null) {
                widget.onPickFile?.call(file, thumbnail);
              }
            },
            child: const ImageSheetButton(),
          )
        ],
      ),
    );
  }
}

class ImageSheetButton extends StatelessWidget {
  final bool isCamera;
  final double? width;
  final double? height;

  const ImageSheetButton(
      {super.key, this.isCamera = false, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: width ?? SizeConfig.screenWidth * .40,
        height: height ?? SizeConfig.screenWidth * .40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: context.colorScheme.primary, width: 3),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            RSizedBox(
              height: 60,
              child: SvgPicture.asset(
                isCamera ? Assets.icons.camera : Assets.icons.gallery,
                colorFilter: ColorFilter.mode(
                    context.colorScheme.primary, BlendMode.srcIn),
              ),
            ),
            const Spacer(),
            AppText(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.primary,
              text: isCamera
                  ? context.localizations.pickImage
                  : context.localizations.chooseFromGallery,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class MediaSheetButton extends StatelessWidget {
  final String text;
  final Color color;
  final String image;
  final double? width;
  final double? height;

  const MediaSheetButton(
      {super.key,
      required this.text,
      required this.image,
      this.width,
      this.height,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: width ?? SizeConfig.screenWidth * .40,
        height: height ?? SizeConfig.screenWidth * .30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: SvgPicture.asset(
                image,
                width: 30.h,
                colorFilter:
                    const ColorFilter.mode(Colors.white, BlendMode.srcIn),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            AppText(
              fontWeight: FontWeight.w600,
              color: context.colorScheme.primary,
              text: text,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
