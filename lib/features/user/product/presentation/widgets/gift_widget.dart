import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/user/order/presentation/bloc/cart/cart_cubit.dart';
import 'package:taxito/widgets/info_design_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../captain/settings/presentation/bloc/settings_bloc.dart';

class GiftWidget extends StatelessWidget {
  const GiftWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final bloc = context.read<CartCubit>();
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xffF3F6FB),
            borderRadius: BorderRadius.circular(18),
          ),
          child: InfoDesignItem(
            icon: Assets.images.gifts.path,
            title:
                "${context.localizations.gift1} ${((context.read<SettingsBloc>().settingsModel?.points_equivalent_to_iqd ?? 1) * bloc.amount).toInt()} ${context.localizations.gift2}",
          ),
        );
      },
    );
  }
}
