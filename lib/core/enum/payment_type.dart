import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/cupertino.dart';

enum PaymentType {
  cash("cash"),
  zainCash("zain_cash"),
  fastPay("fast_pay"),
  fib("fib"),
  visa("visa"),
  wallet("wallet");

  final String name;

  const PaymentType(this.name);
}

PaymentType? handleStringToPayment({String? payment}) {
  if (payment == "zain_cash") {
    return PaymentType.zainCash;
  } else if (payment == "fast_pay") {
    return PaymentType.fastPay;
  } else if (payment == "fib") {
    return PaymentType.fib;
  } else if (payment == "visa") {
    return PaymentType.visa;
  } else if (payment == "wallet") {
    return PaymentType.wallet;
  } else {
    return PaymentType.cash;
  }
}

String handlePaymentTypeToString(
    {required PaymentType payment, required BuildContext context}) {
  if (payment == PaymentType.wallet) {
    return context.localizations.wallet;
  } else if (payment == PaymentType.visa) {
    return context.localizations.visa;
  } else {
    return context.localizations.cash;
  }
}
