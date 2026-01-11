import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';

class ImagePickerDialog extends StatelessWidget {
  final Function(String) onImageSelected;

  const ImagePickerDialog({
    super.key,
    required this.onImageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.localizations.chooseImageSource),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: Text(context.localizations.camera),
            onTap: () {
              Navigator.of(context).pop();
              onImageSelected('camera');
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: Text(context.localizations.gallery),
            onTap: () {
              Navigator.of(context).pop();
              onImageSelected('gallery');
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(context.localizations.cancel),
        ),
      ],
    );
  }
}
