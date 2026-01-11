import 'dart:io';

import 'package:taxito/features/captain/auth/data/models/response/user_model_helper.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../../../widgets/image_picker/media_form_field.dart';

class DriverAccountProfileImage extends StatelessWidget {
  final Function(File) onDataReceived;
  const DriverAccountProfileImage({super.key, required this.onDataReceived});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MediaFormField(
        defaultImage: AppImage.asset(Assets.images.dummyUser.path),
        height: SizeConfig.screenWidth * .3,
        width: SizeConfig.screenWidth * .3,
        onDataReceived: onDataReceived,
        initialImage: UserDataService().getUserData()?.profileImage,
      ),
    );
  }
}
