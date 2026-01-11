import 'package:taxito/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/welcome/welcome_body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(showBackButton: false,),
      body: WelcomeBody(),
    );
  }
}
