import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/features/user/main/presentation/cubit/main/main_cubit.dart';
import 'package:taxito/gen/assets.gen.dart';

import '../../../../captain/settings/settings_helper.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        final bloc = context.read<MainCubit>();
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            useLegacyColorScheme: false,
            onTap: (index) {
              if((index ==3 || index ==1) && ApiConfig.isGuest == true){
                  SettingsHelper().showGuestDialog(context);
                  return ;
              }
              bloc.changeCurrentBottomNavIndex(currentIndex: index);
            },
            currentIndex: bloc.index,
            items: [
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Assets.icons.home),
                  activeIcon: SvgPicture.asset(Assets.icons.homeFilled,
                      colorFilter: ColorFilter.mode(
                          context.colorScheme.primary, BlendMode.srcIn)),
                  label: context.localizations.home),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Assets.icons.tripHistory),
                  activeIcon: SvgPicture.asset(Assets.icons.tripHistory,
                      colorFilter: ColorFilter.mode(
                          context.colorScheme.primary, BlendMode.srcIn)),
                  label: context.localizations.tripHistory),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Assets.icons.cart),
                  activeIcon: SvgPicture.asset(Assets.icons.cart,
                      colorFilter: ColorFilter.mode(
                          context.colorScheme.primary, BlendMode.srcIn)),
                  label: context.localizations.cart),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Assets.icons.myOrders),
                  activeIcon: SvgPicture.asset(Assets.icons.myOrders,
                      colorFilter: ColorFilter.mode(
                          context.colorScheme.primary, BlendMode.srcIn)),
                  label: context.localizations.myOrders),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(Assets.icons.user),
                  activeIcon: SvgPicture.asset(Assets.icons.user,
                      colorFilter: ColorFilter.mode(
                          context.colorScheme.primary, BlendMode.srcIn)),
                  label: context.localizations.account),
            ]);
      },
    );
  }
}
