import 'dart:io';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/image_picker/pick_multi_media_sheet.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../../../core/utils/app_size.dart';
import '../../../../../../../gen/assets.gen.dart';
import '../../../../../../../widgets/image_picker/app_image.dart';

class ProductImagePickerWidget extends StatefulWidget {
  final Function(List<String>) images;
  final List<String> imagesListFromApi;

  const ProductImagePickerWidget({
    super.key,
    required this.images,
    required this.imagesListFromApi,
  });

  @override
  State<ProductImagePickerWidget> createState() =>
      _ProductImagePickerWidgetState();
}

class _ProductImagePickerWidgetState extends State<ProductImagePickerWidget> {
  List<String> images = [];
  Map<String, String> imagesMap = {};

  @override
  void initState() {
    images = widget.imagesListFromApi;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagesListFromApi.isNotEmpty) {
      return GestureDetector(
        onTap: () async => _pickImage(context: context),
        child: Column(
          children: [
            ...List.generate((images.length / 5).ceil(), (rowIndex) {
              final start = rowIndex * 5;
              final end = (start + 5).clamp(0, images.length);
              final rowImages = images.sublist(start, end);
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ...rowImages.map((image) {
                    return Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 4,
                          ),
                          width: SizeConfig.screenWidth * .16,
                          height: SizeConfig.screenWidth * .16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: image.contains('http')
                                  ? NetworkImage(image) as ImageProvider
                                  : FileImage(File(image)) as ImageProvider,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              if (image.contains('http')) {
                                if (widget.imagesListFromApi.isNotEmpty) {
                                  final data = widget.imagesListFromApi
                                      .where((element) => element == image)
                                      .toList();
                                  if (data.isNotEmpty) {
                                    /// Delete Image From Api
                                  }
                                }
                              } else {
                                imagesMap.removeWhere(
                                  (key, value) => key == image,
                                );
                                widget.images(imagesMap.values.toList());
                              }
                              setState(() {
                                images.removeWhere(
                                  (element) => element == image,
                                );
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.colorScheme.error,
                              ),
                              padding: const EdgeInsets.all(2),
                              child: const Icon(
                                Icons.close,
                                size: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                  ...List.generate(
                    (rowIndex == (images.length / 5).floor())
                        ? (5 - rowImages.length)
                        : 0,
                    (index) => GestureDetector(
                      onTap: () async => _pickImage(context: context),
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        width: SizeConfig.screenWidth * .16,
                        height: SizeConfig.screenWidth * .16,
                        decoration: BoxDecoration(
                          color: context.colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: context.colorScheme.outline,
                            strokeAlign: BorderSide.strokeAlignOutside,
                            width: 2,
                          ),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Center(
                          child: AppImage.asset(Assets.icons.documentUpload),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      );
    } else {
      return GestureDetector(
        onTap: () async => _pickImage(context: context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...images.map((image) {
              return Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: SizeConfig.screenWidth * .16, // حجم ثابت لكل عنصر
                    height: SizeConfig.screenWidth * .16,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: image.contains('http')
                            ? NetworkImage(image) as ImageProvider
                            : FileImage(File(image)) as ImageProvider,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        if (image.contains('http')) {
                          if (widget.imagesListFromApi.isNotEmpty) {
                            final data = widget.imagesListFromApi
                                .where((element) => element == image)
                                .toList();
                            if (data.isNotEmpty) {}
                          }
                        } else {
                          imagesMap.removeWhere((key, value) => key == image);
                          widget.images(imagesMap.values.toList());
                        }
                        setState(() {
                          images.removeWhere((element) => element == image);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.colorScheme.error,
                        ),
                        padding: const EdgeInsets.all(2),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            ...List.generate(
              5 - images.length,
              (index) => GestureDetector(
                onTap: () async => _pickImage(context: context),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: SizeConfig.screenWidth * .16,
                  // حجم ثابت لكل عنصر
                  height: SizeConfig.screenWidth * .16,
                  decoration: BoxDecoration(
                    color: context.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: context.colorScheme.outline,
                      strokeAlign: BorderSide.strokeAlignOutside,
                      width: 2,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Center(
                    child: AppImage.asset(Assets.icons.documentUpload),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  void _pickImage({required BuildContext context}) async {
    await showMaterialModalBottomSheet(
      context: context,
      shape: const OutlineInputBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => PickMediaFileSheetMultiImages(
        onPickFile: (p0) async {
          if (p0.isNotEmpty) {
            for (var element in p0) {
              images.add(element.path);
            }
            setState(() {});
          }
          widget.images(images);
          Navigator.pop(context);
        },
      ),
    );
  }
}
