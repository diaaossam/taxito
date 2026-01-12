import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/config/dependencies/injectable_dependencies.dart';
import 'package:taxito/core/bloc/global_cubit/global_cubit.dart';
import 'package:nested/nested.dart';
import '../../features/captain/settings/presentation/bloc/settings_bloc.dart';
import '../../features/captain/user/presentation/bloc/user_bloc.dart';
import '../../features/user/location/presentation/cubit/my_address/my_address_cubit.dart';
import '../../features/user/order/presentation/bloc/cart/cart_cubit.dart';
import '../../features/user/product/presentation/cubit/product/product_cubit.dart';
import 'socket/socket_cubit.dart';

class AppBloc {
  static List<SingleChildWidget> providers = [
    BlocProvider(create: (context) => sl<GlobalCubit>()..getAppSettings()),
    BlocProvider(
      create: (context) => sl<SettingsBloc>()..add(GetAppSettingsEvent()),
    ),
    BlocProvider(create: (context) => sl<UserBloc>()),
    BlocProvider(create: (context) => sl<ProductCubit>()),
    BlocProvider(create: (context) => sl<MyAddressCubit>()..getMyAddress()),
    BlocProvider(create: (context) => sl<CartCubit>()),
    BlocProvider(create: (context) {
      final socketCubit = sl<SocketCubit>();
      return socketCubit;
    }),
  ];
}
