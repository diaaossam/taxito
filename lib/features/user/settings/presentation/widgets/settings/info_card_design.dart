import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/api_config.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/auth/presentation/pages/register_screen.dart';
import 'package:aslol/features/settings/settings_helper.dart';
import 'package:aslol/features/user/presentation/bloc/user_bloc.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../auth/data/models/response/user_model_helper.dart';
import '../../../../auth/presentation/pages/update_profile_screen.dart';

class InfoCardDesign extends StatelessWidget {
  const InfoCardDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    height: SizeConfig.bodyHeight * .1,
                    width: SizeConfig.bodyHeight * .1,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: context.colorScheme.primary,
                        width: 1.0,
                      ),
                    ),
                    child: ClipOval(
                      child: ApiConfig.isGuest == true
                          ? AppImage.asset(Assets.images.logo.path)
                          : CachedNetworkImage(
                              imageUrl:
                                  UserDataService().getUserData()?.image ?? "",
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: SizeConfig.screenWidth * .03,
                  ),
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: ApiConfig.isGuest == true
                            ? context.localizations.guest
                            : UserDataService().getUserData()?.name ?? '',
                        textSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        height: SizeConfig.bodyHeight * .01,
                      ),
                      if (ApiConfig.isGuest != true)
                        Row(
                          children: [
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: AppText(
                                text: UserDataService().getUserData()?.phone ??
                                    '',
                                textSize: 13,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(
                        height: SizeConfig.bodyHeight * .01,
                      ),
                    ],
                  )),
                ],
              ),
            ),
            InkWell(
              onTap: () => context.navigateTo(
                const RegisterScreen(),
                callback: (data) {
                  UserDataService().reloadUserData(context: context);
                },
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.colorScheme.onSurface)),
                child: AppText(text: context.localizations.edit),
              ),
            ),
          ],
        );
      },
    );
  }
}
