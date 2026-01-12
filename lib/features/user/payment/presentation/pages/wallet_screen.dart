import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../bloc/wallet/wallet_cubit.dart';
import '../widgets/my_wallet_body.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WalletCubit>()..init(),
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.localizations.walletBalance,
        ),
        body: const MyWalletBody(),
      ),
    );
  }
}
