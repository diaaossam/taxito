import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/enum/payment_type.dart';
import '../../../../../gen/assets.gen.dart';

class PaymentModel {
  final String title;
  final String icon;
  final PaymentType paymentMethod;

  PaymentModel({
    required this.title,
    required this.icon,
    required this.paymentMethod,
  });

  static List<PaymentModel> allPayments({
    required BuildContext context,
    required bool isCharge,
  }) {
    return [
      PaymentModel(
        title: context.localizations.cash,
        icon: Assets.images.cash.path,
        paymentMethod: PaymentType.cash,
      ),
      if (isCharge) ...[
        PaymentModel(
          title: context.localizations.visa,
          icon: Assets.images.card.path,
          paymentMethod: PaymentType.visa,
        ),
      ],

      PaymentModel(
        title: context.localizations.wallet,
        icon: Assets.images.card.path,
        paymentMethod: PaymentType.wallet,
      ),
    ];
  }
}
