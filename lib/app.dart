import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/config/helper/context_helper.dart';
import 'package:taxito/core/bloc/global_cubit/global_cubit.dart';
import 'package:taxito/core/bloc/global_cubit/global_state.dart';
import 'package:taxito/generated/l10n.dart';
import 'core/bloc/app_bloc.dart';
import 'config/theme/app_theme.dart';
import 'core/utils/app_strings.dart';
import 'features/common/start/presentation/pages/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<GlobalCubit, GlobalState>(
        builder: (context, state) {
          final bloc = context.read<GlobalCubit>();
          return ScreenUtilInit(
            designSize: const Size(360, 850),
            minTextAdapt: true,
            splitScreenMode: true,
            child: MaterialApp(
              navigatorKey: NavigationService.navigatorKey,
              title: AppStrings.appName,
              builder: (context, child) {
                return SafeArea(
                  top: false,
                  right: false,
                  left: false,
                  bottom: true,
                  child: child!,
                );
              },
              home: const SplashScreen(),
              debugShowCheckedModeBanner: false,
              theme: ThemeManger.appTheme(language: bloc.language),
              darkTheme: ThemeManger.blackTheme(language: bloc.language),
              locale: context.read<GlobalCubit>().locale,
              themeMode: GlobalCubit.get(context).themeMode,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
            ),
          );
        },
      ),
    );
  }
}
