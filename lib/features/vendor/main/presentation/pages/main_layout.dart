import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:force_update_helper/force_update_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../config/helper/context_helper.dart';
import '../../../../../core/bloc/socket/socket_cubit.dart';
import '../../../../../widgets/update_dialog.dart';
import '../../../../captain/settings/presentation/bloc/settings_bloc.dart';
import '../../../categories/presentation/pages/categories_screen.dart';
import '../../../attributes/presentation/pages/main_attribute_screen.dart';
import '../../../product/presentation/pages/my_product_screen.dart';
import '../../../settings/presentation/pages/settings_screen.dart';
import '../cubit/delivery_main/delivery_main_cubit.dart';
import '../widgets/driver_main_layout/animated_bottom_bar.dart';
import 'delivery_home.dart';

class SupplierMainLayout extends StatefulWidget {
  final num? orderId;

  const SupplierMainLayout({super.key, this.orderId});

  @override
  State<SupplierMainLayout> createState() => _SupplierMainLayoutState();
}

class _SupplierMainLayoutState extends State<SupplierMainLayout> {
  List<Widget> screens() {
    return [
      DeliveryHome(orderId: widget.orderId),
      const CategoriesScreen(),
      const MyProductScreen(),
      const MainAttributeScreen(),
      const SettingsScreen(),
    ];
  }

  @override
  void initState() {
    context.read<SocketCubit>().initSocketConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.read<SettingsBloc>().settingsModel;
    return ForceUpdateWidget(
      navigatorKey: NavigationService.navigatorKey,
      allowCancel: false,
      showStoreListing: (storeUrl) async {
        if (await canLaunchUrl(storeUrl)) {
          await launchUrl(storeUrl, mode: LaunchMode.externalApplication);
        }
      },
      showForceUpdateAlert: (context, allowCancel) => showUpdateDialog(context),
      forceUpdateClient: ForceUpdateClient(
        fetchRequiredVersion: () => Future.value(
          Platform.isIOS
              ? model?.fetchRequiredIosVersion ?? ""
              : model?.fetchRequiredAndroidVersion ?? "",
        ),
        iosAppStoreId: "6754816494",
      ),
      child: BlocProvider(
        create: (context) => sl<DeliveryMainCubit>(),
        child: BlocBuilder<DeliveryMainCubit, DeliveryMainState>(
          builder: (context, state) {
            return Scaffold(
              body: screens()[context.read<DeliveryMainCubit>().currentIndex],
              bottomNavigationBar: const AnimatedBottomBar(),
            );
          },
        ),
      ),
    );
  }
}
