import 'package:aslol/core/bloc/global_cubit/global_cubit.dart';
import 'package:aslol/core/bloc/global_cubit/global_state.dart';
import 'package:aslol/core/enum/language.dart';
import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/api_config.dart';
import 'package:aslol/core/utils/app_constant.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/auth/presentation/pages/login_screen.dart';
import 'package:aslol/features/location/presentation/widgets/address_dialog_design.dart';
import 'package:aslol/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:aslol/features/notifications/presentation/pages/notification_screen.dart';
import 'package:aslol/features/settings/domain/entities/settings_entity.dart';
import 'package:aslol/features/settings/presentation/pages/customer_service_screen.dart';
import 'package:aslol/features/settings/presentation/widgets/copywrite_widget.dart';
import 'package:aslol/features/settings/presentation/widgets/settings/info_card_design.dart';
import 'package:aslol/features/settings/presentation/widgets/settings/settings_item_design.dart';
import 'package:aslol/features/settings/settings_helper.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/dependencies/injectable_dependencies.dart';
import '../../../auth/presentation/cubit/logout/logout_cubit.dart';
import '../../../product/presentation/pages/favourite_screen.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/settings/settings_header_design.dart';
import 'about_app_screen.dart';
import 'choose_language_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .02),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                const InfoCardDesign(),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                const SettingsHeaderDesign(),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
                BlocProvider(
                  create: (context) =>
                      sl<NotificationsCubit>()..getNotificationCount(),
                  child: BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                      return SettingsItemDesign(
                          settingsEntity: SettingsEntity(
                              widget: state is GetCountNotificationsSuccess &&
                                      state.count != 0
                                  ? Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: context.colorScheme.tertiary),
                                      child: Center(
                                          child: Text(
                                        "${state.count}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                      )),
                                    )
                                  : const SizedBox.shrink(),
                              id: 1,
                              press: () => ApiConfig.isGuest == true
                                  ? null
                                  : context.navigateTo(
                                      const NotificationScreen(),
                                      callback: (p0) => context
                                          .read<NotificationsCubit>()
                                          .getNotificationCount(),
                                    ),
                              title: context.localizations.notifications,
                              image: Assets.icons.notification));
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
                SettingsItemDesign(
                    settingsEntity: SettingsEntity(
                        id: 1,
                        press: () => ApiConfig.isGuest == true
                            ? null
                            : context.navigateTo(const FavouriteScreen()),
                        title: context.localizations.favourites,
                        image: Assets.icons.heart)),
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
                SettingsItemDesign(
                  settingsEntity: SettingsEntity(
                      id: 1,
                      iconColor: Colors.blueAccent,
                      press: () => ApiConfig.isGuest == true
                          ? null
                          : context.navigateTo(AddressDialogDesign(
                              onChoose: (p0) {},
                              isDialog: false,
                            )),
                      title: context.localizations.address,
                      image: Assets.icons.location3),
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
                SettingsItemDesign(
                  settingsEntity: SettingsEntity(
                      id: 1,
                      iconColor: Colors.green,
                      press: () => context.navigateTo(CustomerServiceScreen()),
                      title: context.localizations.technicalSupport,
                      image: Assets.icons.customerService),
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
                if (context
                    .read<SettingsBloc>()
                    .settingsModel
                    ?.showCopyright ==
                    true) ...[

                  SettingsItemDesign(
                      settingsEntity: SettingsEntity(
                          id: 1,
                          press: () =>
                              context.navigateTo(const AboutAppScreen()),
                          title: context.localizations.aboutApp,
                          image: Assets.icons.shop)),
                  SizedBox(
                    height: SizeConfig.bodyHeight * .01,
                  ),
                ],
                BlocBuilder<GlobalCubit, GlobalState>(
                  builder: (context, state) {
                    final bloc = context.read<GlobalCubit>();
                    return SettingsItemDesign(
                      settingsEntity: SettingsEntity(
                          widget: AppText(
                            text: bloc.language == Language.arabic
                                ? context.localizations.arabic
                                : context.localizations.english,
                            color: context.colorScheme.shadow,
                            fontWeight: FontWeight.w500,
                          ),
                          id: 1,
                          press: () async => await showDialog(
                                context: context,
                                builder: (context) =>
                                    const ChooseLanguageScreen(),
                              ),
                          title: context.localizations.language,
                          image: Assets.icons.global),
                    );
                  },
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .01,
                ),
                BlocProvider(
                  create: (context) => sl<LogoutCubit>(),
                  child: BlocConsumer<LogoutCubit, LogoutState>(
                    listener: (context, state) {
                      if (state is LogoutUserSuccess) {
                        context.navigateTo(const LoginScreen());
                      }
                      if (state is LogoutUserError) {
                        AppConstant.showCustomSnakeBar(
                            context, state.msg, false);
                      }
                    },
                    builder: (context, state) {
                      final bloc = context.read<LogoutCubit>();
                      return SettingsItemDesign(
                          settingsEntity: SettingsEntity(
                              id: 1,
                              press: () => SettingsHelper().showAppDialog(
                                      context: context,
                                      height: SizeConfig.bodyHeight * .34,
                                      isAccept: (p0) async {
                                        if (p0) {
                                          bloc.logoutAccount();
                                        }
                                      },
                                      title: context.localizations.logoutBody),
                              title: context.localizations.logout,
                              image: Assets.icons.logout));
                    },
                  ),
                ),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),

                CopyWriteWidget(),
                SizedBox(
                  height: SizeConfig.bodyHeight * .04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
