import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/custom_text_form_field.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteProductDialog extends StatefulWidget {
  const NoteProductDialog({super.key});

  @override
  State<NoteProductDialog> createState() => _NoteProductDialogState();
}

class _NoteProductDialogState extends State<NoteProductDialog> {
  String note = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.bodyHeight * .4,
      child: Scaffold(
        body: Padding(
          padding: screenPadding(),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
              Row(
                children: [
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36.h,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: context.colorScheme.onSurface),
                      ),
                      child: const Icon(Icons.close, size: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
              CustomTextFormField(
                prefixIcon: AppImage.asset(Assets.icons.messageQuestion),
                maxLines: 5,
                hintText: context.localizations.writeNoteHere,
                onChanged: (value) => setState(() {
                  if (value == null || value.isEmpty) {
                    note = '';
                    return;
                  }
                  note = value;
                }),
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .04,
              ),
              CustomButton(
                text: context.localizations.saveNote,
                press: () => Navigator.pop(context,note),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
