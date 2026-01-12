import 'package:taxito/core/bloc/global_cubit/global_cubit.dart';
import 'package:taxito/core/bloc/global_cubit/global_state.dart';
import 'package:taxito/core/enum/language.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:taxito/core/utils/api_config.dart';
import 'package:taxito/core/utils/app_constant.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/captain/settings/domain/entities/settings_entity.dart';
import 'package:taxito/features/captain/settings/presentation/pages/customer_service_screen.dart';
import 'package:taxito/features/captain/settings/presentation/widgets/settings/settings_item_design.dart';
import 'package:taxito/features/captain/settings/settings_helper.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../user/notifications/presentation/cubit/notifications_cubit.dart';
import '../../../../user/notifications/presentation/pages/notification_screen.dart';
import '../../../auth/presentation/cubit/logout/logout_cubit.dart';
import '../../../auth/presentation/widgets/info_card.dart';
import '../../../start/presentation/pages/welcome_screen.dart';
import '../bloc/settings_bloc.dart';
import '../widgets/copywrite_widget.dart';
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
            padding: screenPadding(),
            child: Column(
              children: [
                SizedBox(height: SizeConfig.bodyHeight * .04),
                const InfoCardDesign(),
                SizedBox(height: SizeConfig.bodyHeight * .04),
                BlocProvider(
                  create: (context) =>
                      sl<NotificationsCubit>()..getNotificationCount(),
                  child: BlocBuilder<NotificationsCubit, NotificationsState>(
                    builder: (context, state) {
                      return SettingsItemDesign(
                        settingsEntity: SettingsEntity(
                          widget:
                              state is GetCountNotificationsSuccess &&
                                  state.count != 0
                              ? Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: context.colorScheme.tertiary,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${state.count}",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          id: 1,
                          press: () => context.navigateTo(
                            const NotificationScreen(),
                            callback: (p0) => context
                                .read<NotificationsCubit>()
                                .getNotificationCount(),
                          ),
                          title: context.localizations.notifications,
                          image: Assets.icons.notification,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: SizeConfig.bodyHeight * .01),
                SettingsItemDesign(
                  settingsEntity: SettingsEntity(
                    id: 1,
                    iconColor: Colors.green,
                    press: () => context.navigateTo(CustomerServiceScreen()),
                    title: context.localizations.technicalSupport,
                    image: Assets.icons.customerService,
                  ),
                ),

                if (context.read<SettingsBloc>().settingsModel?.showCopyright ==
                    true) ...[
                  SizedBox(height: SizeConfig.bodyHeight * .01),
                  SettingsItemDesign(
                    settingsEntity: SettingsEntity(
                      id: 1,
                      press: () => context.navigateTo(const AboutAppScreen()),
                      title: context.localizations.aboutApp,
                      image: Assets.icons.shop,
                    ),
                  ),
                ],
                SizedBox(height: SizeConfig.bodyHeight * .01),
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
                          builder: (context) => const ChooseLanguageScreen(),
                        ),
                        title: context.localizations.language,
                        image: Assets.icons.global,
                      ),
                    );
                  },
                ),
                SizedBox(height: SizeConfig.bodyHeight * .01),
                BlocProvider(
                  create: (context) => sl<LogoutCubit>(),
                  child: BlocConsumer<LogoutCubit, LogoutState>(
                    listener: (context, state) {
                      if (state is LogoutUserSuccess) {
                        context.navigateTo(const WelcomeScreen());
                      }
                      if (state is LogoutUserError) {
                        AppConstant.showCustomSnakeBar(
                          context,
                          state.msg,
                          false,
                        );
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
                            title: context.localizations.logoutBody,
                          ),
                          title: context.localizations.logout,
                          image: Assets.icons.logout,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: SizeConfig.bodyHeight * .04),

                const CopyWriteWidget(),
                SizedBox(height: SizeConfig.bodyHeight * .04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
