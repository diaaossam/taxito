import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/core/bloc/global_cubit/global_cubit.dart';
import 'package:nested/nested.dart';
import '../../features/captain/settings/presentation/bloc/settings_bloc.dart';
import '../../features/captain/user/presentation/bloc/user_bloc.dart';
import 'socket/socket_cubit.dart';

class AppBloc {
  static List<SingleChildWidget> providers = [
    BlocProvider(create: (context) => sl<GlobalCubit>()..getAppSettings()),
    BlocProvider(
      create: (context) => sl<SettingsBloc>()..add(GetAppSettingsEvent()),
    ),
    BlocProvider(create: (context) => sl<UserBloc>()),
    BlocProvider(
      create: (context) {
        final socketCubit = sl<SocketCubit>();
        return socketCubit;
      },
    ),
  ];
}
