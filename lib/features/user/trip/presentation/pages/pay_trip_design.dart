import 'package:taxito/core/enum/payment_type.dart';
import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../widgets/charge_methods_list.dart';

class PayTripDesign extends StatefulWidget {
  final Function(PaymentType) paymentMethod;

  const PayTripDesign({super.key, required this.paymentMethod});

  @override
  State<PayTripDesign> createState() => _PayTripDesignState();
}

class _PayTripDesignState extends State<PayTripDesign> {
  PaymentType? paymentType;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.bodyHeight * .6,
      child: Scaffold(
        body: Container(
          height: SizeConfig.bodyHeight * .6,
          padding:
              EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: SizeConfig.bodyHeight * .04,
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Row(
                  children: [
                    AppImage.asset(Assets.icons.arrowBack),
                    5.horizontalSpace,
                    AppText(
                      text: context.localizations.choosePaymentMethod,
                      fontWeight: FontWeight.bold,
                      textSize: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .01,
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    start: SizeConfig.screenWidth * .06),
                child: AppText(
                  text: context.localizations.choosePaymentMethodBody,
                  maxLines: 2,
                  textSize: 12,
                ),
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .04,
              ),
              ChargeMethodsList(
                paymentMethod: (p0) => setState(() => paymentType = p0),
                isCharge: false,
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .02,
              ),
              Padding(
                padding: screenPadding(),
                child: CustomButton(
                    isActive: paymentType != null,
                    text: context.localizations.confirm,
                    press: () => widget.paymentMethod(paymentType!)),
              ),
              SizedBox(
                height: SizeConfig.bodyHeight * .04,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
