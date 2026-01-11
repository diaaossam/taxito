import 'dart:io';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/image_picker/media_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../../../generated/l10n.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/image_picker/pick_image_sheet.dart';
import '../../../../../widgets/loading/loading_widget.dart';

class IdPhotoPicker extends StatefulWidget {
  final String? initialImage;
  final String name;
  final String? title;
  final double? height;
  final double? width;
  final bool isClickable;
  final bool isLoading;
  final String? Function(dynamic)? validator;
  final Function(dynamic)? callback;

  const IdPhotoPicker({
    super.key,
    this.isClickable = true,
    this.callback,
    this.initialImage,
    required this.name,
    this.height,
    this.width,
    this.title,
    this.isLoading = false,
    this.validator,
  });

  @override
  _IdPhotoPickerState createState() => _IdPhotoPickerState();
}

class _IdPhotoPickerState extends State<IdPhotoPicker> {
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...{
          AppText(
            text: widget.title!,
            fontWeight: FontWeight.bold,
            textSize: 14,
          ),
          12.verticalSpace,
        },
        FormBuilderField<String>(
          name: widget.name,
          validator: widget.validator,
          initialValue: widget.initialImage,
          builder: (FormFieldState<String?> field) {
            return GestureDetector(
              onTap: !widget.isClickable
                  ? null
                  : () async {
                      await showMaterialModalBottomSheet(
                        context: context,
                        shape: const OutlineInputBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16))),
                        builder: (context) => PickMediaFileSheet(
                          mediaType: MediaType.image,
                          onPickFile: (file, thumpNail) {
                            field.didChange(file.path);
                            setState(() => _selectedFile = file);
                          },
                        ),
                      );
                    },
              child: Container(
                decoration: BoxDecoration(
                  color: context.colorScheme.onPrimary,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: field.hasError
                        ? context.colorScheme.error
                        : context.colorScheme.outline,
                    width: 2,
                  ),
                ),
                width: widget.width,
                height: widget.height,
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Center(
                      child:
                          _setUpImageFromUrlOrFile(field.value, _selectedFile),
                    ),
                    if (widget.isLoading)
                      Container(
                        color: Colors.black.withValues(alpha: 0.2),
                        child: Center(
                          child: Column(
                            children: [
                              const LoadingWidget(),
                              8.verticalSpace,
                              AppText(
                                text: context.localizations.uploading,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _setUpImageFromUrlOrFile(String? value, File? file) {
    if (file != null) {
      return Image.file(file, fit: BoxFit.cover);
    } else if (value != null && value.startsWith("http")) {
      return Image.network(value, fit: BoxFit.cover);
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [AppText(text: S.current.photoValidation)],
      );
    }
  }
}
