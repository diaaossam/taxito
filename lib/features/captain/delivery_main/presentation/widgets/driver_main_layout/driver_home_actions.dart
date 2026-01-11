import 'package:flutter/material.dart';
import '../../../../../../core/enum/choose_enum.dart';
import '../../../../../../core/utils/app_size.dart';

class DriverHomeActions extends StatelessWidget {
  final Function(ChooseEnum) callbackAvailability;

  const DriverHomeActions({super.key, required this.callbackAvailability});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      child: Container(
        width: SizeConfig.screenWidth,
        padding: screenPadding(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),

          ],
        ),
      ),
    );
  }
}
