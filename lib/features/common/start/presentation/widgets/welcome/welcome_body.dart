import 'package:taxito/core/data/models/user_type_helper.dart';
import 'package:taxito/core/enum/user_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/auth/presentation/pages/login_screen.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:taxito/widgets/custom_button.dart';
import 'package:taxito/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WelcomeBody extends StatefulWidget {
  const WelcomeBody({super.key});

  @override
  State<WelcomeBody> createState() => _WelcomeBodyState();
}

class _WelcomeBodyState extends State<WelcomeBody> {
  UserType? selectedType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: screenPadding(),
      child: Column(
        children: [
          AppImage.asset(
            Assets.images.logoCirclure.path,
            height: SizeConfig.bodyHeight * .2,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .04),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppText(
                text: context.localizations.welcomeTitle,
                fontWeight: FontWeight.bold,
                textSize: 20,
              ),
              2.horizontalSpace,
              AppText(
                text: "${context.localizations.appName} !",
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
                textSize: 20,
              ),
            ],
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          AppText(
            text: context.localizations.welcomeBody,
            maxLines: 2,
            color: context.colorScheme.shadow,
            textSize: 14,
            fontWeight: FontWeight.w500,
            textHeight: 1.7,
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          Row(
            children: [
              _buildChoice(
                type: UserType.user,
                context: context,
                isSelected: selectedType == UserType.user,
                name: context.localizations.user,
                image: Assets.images.user.path,
              ),
              20.horizontalSpace,
              _buildChoice(
                type: UserType.supplier,
                context: context,
                name: context.localizations.supplier,
                isSelected: selectedType == UserType.supplier,
                image: Assets.images.store.path,
              ),
            ],
          ),
          SizedBox(height: SizeConfig.bodyHeight * .02),
          Row(
            children: [
              _buildChoice(
                type: UserType.driver,
                context: context,
                name: context.localizations.taxiDriver,
                isSelected: selectedType == UserType.driver,
                image: Assets.images.taxi.path,
              ),
              20.horizontalSpace,
              _buildChoice(
                type: UserType.delivery,
                name: context.localizations.delivery,
                context: context,
                isSelected: selectedType == UserType.delivery,
                image: Assets.images.deleivery.path,
              ),
            ],
          ),
          SizedBox(height: SizeConfig.bodyHeight * .06),
          CustomButton(
            text: context.localizations.continueText,
            isActive: selectedType != null,
            press: () {
              UserTypeService().setUserType(selectedType!);
              context.navigateTo(LoginScreen(userType: selectedType!));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChoice({
    required UserType type,
    required BuildContext context,
    required bool isSelected,
    required String name,
    required String image,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedType = type),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: isSelected ? 2 : 1,
              color: isSelected
                  ? context.colorScheme.primary
                  : context.colorScheme.outline,
            ),
            color: isSelected ? context.colorScheme.onPrimary : null,
          ),
          child: Center(
            child: Column(
              children: [
                AppImage.asset(image, height: SizeConfig.bodyHeight * .08),
                10.verticalSpace,
                AppText(text: name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
