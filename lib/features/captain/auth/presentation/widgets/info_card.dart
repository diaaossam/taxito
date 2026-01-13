import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../widgets/app_text.dart';
import '../../../user/presentation/bloc/user_bloc.dart';
import '../../../../common/models/user_model_helper.dart';
import '../pages/driver_register.dart';

class InfoCardDesign extends StatelessWidget {
  const InfoCardDesign({super.key});

  @override
  Widget build(BuildContext context) {
    print(UserDataService().getUserData()?.profileImage ?? "");
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
                      child: CachedNetworkImage(
                        imageUrl:
                            UserDataService().getUserData()?.profileImage ?? "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  SizedBox(width: SizeConfig.screenWidth * .03),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text:
                              "${UserDataService().getUserData()?.firstName} ${UserDataService().getUserData()?.lastName}",
                          textSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * .01),
                        Row(
                          children: [
                            Directionality(
                              textDirection: TextDirection.ltr,
                              child: AppText(
                                text:
                                    UserDataService().getUserData()?.phone ??
                                    '',
                                textSize: 13,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: SizeConfig.bodyHeight * .01),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => context.navigateTo(
                DriverRegisterScreen(
                  isUpdate: true,
                  phone: UserDataService().getUserData()?.phone ?? "",
                ),
                callback: (data) {
                  UserDataService().reloadUserData(context: context);
                },
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.colorScheme.onSurface),
                ),
                child: AppText(text: context.localizations.edit),
              ),
            ),
          ],
        );
      },
    );
  }
}
