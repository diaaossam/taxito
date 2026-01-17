import 'package:taxito/features/user/order/presentation/pages/cart_screen.dart';
import 'package:taxito/features/user/order/presentation/pages/orders_screen.dart';
import 'package:taxito/features/user/product/presentation/pages/all_products_screen.dart';
import 'package:taxito/features/user/trip/presentation/pages/driver_history_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:taxito/features/user/main/presentation/pages/home_screen.dart';
import 'package:taxito/features/user/settings/presentation/pages/settings_screen.dart';

import '../../../../../../core/utils/api_config.dart';
import '../../../domain/usecases/update_device_token.dart';

part 'main_state.dart';

@Injectable()
class MainCubit extends Cubit<MainState> {
  final UpdateDeviceToken updateDeviceToken;

  MainCubit(this.updateDeviceToken) : super(MainInitial()){
    updateDeviceTokenState();
  }

  int index = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const TripHistoryScreen(),
    CartScreen(key: GlobalKey()),
    const OrdersScreen(),
    const SettingsScreen(),
  ];

  void changeCurrentBottomNavIndex({int? currentIndex}) {
    if (currentIndex != null) {
      index = currentIndex;
      if (index == 2) {
        screens.removeAt(2);
        screens.insert(2, CartScreen(key: GlobalKey()));
      }
      emit(ChangeCurrentIndexState(index: currentIndex));
    }
  }

  Future<void> updateDeviceTokenState() async {
    if (ApiConfig.isGuest == true) {
      return;
    }
    final response = await updateDeviceToken();
  }
}
