import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/customer_service/customer_service_body.dart';

class CustomerServiceScreen extends StatelessWidget {
  const CustomerServiceScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.localizations.technicalSupport,
      ),
      body: const CustomerServiceBody(),
    );
  }
}
