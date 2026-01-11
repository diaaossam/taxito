import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_text_form_field.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';

class CartNoteDesign extends StatelessWidget {
  final TextEditingController note;
  const CartNoteDesign({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(
            horizontal: SizeConfig.screenWidth * .02,
            vertical: SizeConfig.bodyHeight * .02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              text: context.localizations.addNote,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: SizeConfig.bodyHeight * .02,
            ),
            CustomTextFormField(
              controller: note,
              prefixIcon: AppImage.asset(Assets.icons.edit),
              hintText: context.localizations.addNoteHint,
            ),
          ],
        ),
      ),
    );
  }
}
