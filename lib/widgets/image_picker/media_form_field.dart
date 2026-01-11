// 🎯 Dart imports:
import 'dart:io';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'app_image.dart';
import 'pick_image_sheet.dart';

enum MediaType { image, video }

class MediaFormField extends StatefulWidget {
  final String? initialImage;
  final String? title;
  final double? height;
  final double? width;
  final VoidCallback? onImagePicked;
  final MediaType mediaType;
  final bool isClickable;
  final bool isLoading;
  final bool removeBorder;
  final Widget? defaultImage;
  final Function(File) onDataReceived;
  final String? Function(dynamic)? validator;

  const MediaFormField({
    super.key,
    this.isClickable = true,
    this.initialImage,
    this.height,
    this.width,
    this.title,
    this.isLoading = false,
    this.onImagePicked,
    this.mediaType = MediaType.image,
    this.removeBorder = false,
    this.defaultImage,
    required this.onDataReceived,
    this.validator,
  });

  @override
  _MediaFormFieldState createState() => _MediaFormFieldState();
}

class _MediaFormFieldState extends State<MediaFormField> {
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<File>(
      name: 'media',
      validator: widget.validator,
      builder: (FormFieldState<File?> field) {
        return Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            GestureDetector(
              onTap: !widget.isClickable
                  ? null
                  : () async {
                      await showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => PickMediaFileSheet(
                          mediaType: widget.mediaType,
                          onPickFile: (file, thumbnail) {
                            setState(() {
                              _selectedFile = file;
                            });
                            widget.onImagePicked?.call();
                            widget.onDataReceived(file);
                          },
                        ),
                      );
                    },
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                width: widget.width,
                height: widget.height,
                clipBehavior: Clip.antiAlias,
                child: _setUpImage(_selectedFile, field),
              ),
            ),
            GestureDetector(
              onTap: !widget.isClickable
                  ? null
                  : () async {
                      await showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) => PickMediaFileSheet(
                          mediaType: widget.mediaType,
                          onPickFile: (file, thumbnail) {
                            setState(() {
                              _selectedFile = file;
                            });
                            widget.onImagePicked?.call();
                            widget.onDataReceived(file);
                          },
                        ),
                      );
                    },
              child: Container(
                padding: EdgeInsets.all(5.w),
                decoration: BoxDecoration(
                    color: context.colorScheme.surface, shape: BoxShape.circle),
                child: SvgPicture.asset(
                  Assets.icons.edit,
                  height: 30,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  _setUpImage(File? selectedFile, FormFieldState<File?> field) {
    if (_selectedFile != null) {
      return Image.file(
        _selectedFile!,
        width: widget.width,
        height: widget.height,
      );
    } else {
      if (widget.initialImage != null) {
        if (widget.initialImage!.contains("assets")) {
          return AppImage.asset(
            widget.initialImage!,
            width: widget.width,
            height: widget.height,
          );
        } else if (widget.initialImage!.contains("http")) {
          return AppImage.network(
            remoteImage: widget.initialImage!,
            width: widget.width,
            height: widget.height,
          );
        }
      } else {
        return widget.defaultImage ??
            AppImage.asset(
              Assets.images.dummyUser.path,
            );
      }
    }
  }
}
