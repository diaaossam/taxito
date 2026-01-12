import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/features/user/order/data/models/payment_model.dart';
import 'package:flutter/material.dart';

import '../../../payment/presentation/widgets/payment_method_type.dart';

class ChargeMethodsList extends StatefulWidget {
  final Function(PaymentType) paymentMethod;
  final bool isCharge;

  const ChargeMethodsList(
      {super.key, required this.paymentMethod, required this.isCharge});

  @override
  State<ChargeMethodsList> createState() => _ChargeMethodsListState();
}

class _ChargeMethodsListState extends State<ChargeMethodsList> {
  PaymentType? paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: PaymentModel.allPayments(
                context: context, isCharge: widget.isCharge)
            .length,
        itemBuilder: (context, index) {
          final model = PaymentModel.allPayments(
              context: context, isCharge: widget.isCharge)[index];
          return GestureDetector(
            onTap: () {
              setState(() => paymentMethod = model.paymentMethod);
              widget.paymentMethod(paymentMethod!);
            },
            child: PaymentMethodTypeWidget(
              selected: paymentMethod == model.paymentMethod,
              model: model,
            ),
          );
        },
      ),
    );
  }
}
