import 'package:taxito/core/enum/payment_type.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../../generated/l10n.dart';

class PaymentModel {
  final PaymentType paymentMethod;
  final String icon;
  final String title;

  PaymentModel({
    required this.paymentMethod,
    required this.icon,
    required this.title,
  });

  static List<PaymentModel> paymentList() {
    return [
      PaymentModel(
        paymentMethod: PaymentType.cash,
        icon: Assets.images.cash.path,
        title: S.current.cash,
      ),
      /*      PaymentModel(
          paymentMethod: PaymentMethod.zainCash,
          icon: Assets.images.zainCash.path,
          title: S.current.zainCash),
      PaymentModel(
          paymentMethod: PaymentMethod.fib,
          icon: Assets.images.fib.path,
          title: S.current.fib),
      PaymentModel(
          paymentMethod: PaymentMethod.fastPay,
          icon: Assets.images.fastPay.path,
          title: S.current.fastPay),
      PaymentModel(
          paymentMethod: PaymentMethod.visa,
          icon: Assets.images.visa.path,
          title: S.current.visa),
      PaymentModel(
          paymentMethod: PaymentMethod.wallet,
          icon: Assets.icons.wallet,
          title: S.current.balance),*/
    ];
  }
}
