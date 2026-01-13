import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/widgets/image_picker/pick_image_sheet.dart';

import '../../config/helper/secure_file_picker.dart';

class PickMediaFileSheetMultiImages extends StatefulWidget {
  const PickMediaFileSheetMultiImages({super.key, required this.onPickFile});

  final Function(List<File>) onPickFile;

  @override
  State<PickMediaFileSheetMultiImages> createState() =>
      _PickMediaFileSheetMultiImagesState();
}

class _PickMediaFileSheetMultiImagesState
    extends State<PickMediaFileSheetMultiImages> {
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: SizeConfig.bodyHeight * .27,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final XFile? images = await picker.pickImage(
                source: ImageSource.camera,
              );
              if (images != null) {
                List<File> files = [];
                final imageFile = File(images.path);
                final data = await SecureFilePicker.compressImage(imageFile);
                files = [data];
                widget.onPickFile(files);
              }
            },
            child: const ImageSheetButton(isCamera: true),
          ),
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () async {
              final List<XFile> images = await picker.pickMultiImage();
              if (images.isNotEmpty) {
                List<File> files = [];
                for (var element in images) {
                  final data = await SecureFilePicker.compressImage(
                    File(element.path),
                  );
                  files.add(data);
                }
                widget.onPickFile(files);
              }
            },
            child: const ImageSheetButton(),
          ),
        ],
      ),
    );
  }
}
