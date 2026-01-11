import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../../widgets/app_text.dart';
import '../../cubit/delivery_main/delivery_main_cubit.dart';

class AnimatedBottomBar extends StatefulWidget {
  const AnimatedBottomBar({super.key});

  @override
  State<AnimatedBottomBar> createState() => _AnimatedBottomBarState();
}

class _AnimatedBottomBarState extends State<AnimatedBottomBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeliveryMainCubit, DeliveryMainState>(
      builder: (context, state) {
        final bloc = context.read<DeliveryMainCubit>();
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          useLegacyColorScheme: false,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) => bloc.changeBottomNavIndex(index: index),
          currentIndex: bloc.currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(Assets.icons.home),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.home,
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.shadow,
                    ),
                  ],
                ),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.home,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.surface,
                        BlendMode.srcIn,
                      ),
                    ),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.home,
                      color: context.colorScheme.surface,
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              label: context.localizations.home,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(Assets.icons.category2),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.categories,
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.shadow,
                    ),
                  ],
                ),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.category2,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.surface,
                        BlendMode.srcIn,
                      ),
                    ),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.categories,
                      color: context.colorScheme.surface,
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              label: context.localizations.categories,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(Assets.icons.shop),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.products,
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.shadow,
                    ),
                  ],
                ),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.shop,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.surface,
                        BlendMode.srcIn,
                      ),
                    ),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.products,
                      color: context.colorScheme.surface,
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              label: context.localizations.categories,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.myOrders,
                      color: context.colorScheme.shadow,
                    ),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.addiontion,
                      textSize: 12,
                      color: context.colorScheme.shadow,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.myOrders,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.surface,
                        BlendMode.srcIn,
                      ),
                    ),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.addiontion,
                      color: context.colorScheme.surface,
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              label: context.localizations.home,
            ),
            BottomNavigationBarItem(
              icon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.profile,
                      color: context.colorScheme.shadow,
                    ),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.profile1,
                      textSize: 12,
                      color: context.colorScheme.shadow,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              activeIcon: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    SvgPicture.asset(
                      Assets.icons.profile,
                      colorFilter: ColorFilter.mode(
                        context.colorScheme.surface,
                        BlendMode.srcIn,
                      ),
                    ),
                    6.verticalSpace,
                    AppText(
                      text: context.localizations.profile1,
                      color: context.colorScheme.surface,
                      textSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              label: context.localizations.profile,
            ),
          ],
        );
      },
    );
  }
}
