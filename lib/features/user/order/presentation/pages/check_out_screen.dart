import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/checkout_body/check_out_body.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.localizations.payment,
      ),
      body: const CheckOutBody(),
    );
  }
}
