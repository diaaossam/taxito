import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/extensions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/data/models/trip_model.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../driver_main/presentation/pages/driver_main_layout.dart';
import '../../../settings/presentation/bloc/settings_bloc.dart';
import '../../../settings/settings_helper.dart';
import '../bloc/payment_driver_confirmation/payment_confirmation_cubit.dart';

class ConfirmationPaymentDialog extends StatelessWidget {
  final TripModel tripModel;

  const ConfirmationPaymentDialog({super.key, required this.tripModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PaymentConfirmationCubit>(),
      child: BlocConsumer<PaymentConfirmationCubit, PaymentConfirmationState>(
        listener: (context, state) {
          if (state is AcceptPaymentRequestSuccess) {
            context.navigateToAndFinish(const DriverMainLayout());
          }
        },
        builder: (context, state) {
          return AlertDialog(
            content: PopScope(
              canPop: false,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                height: SizeConfig.bodyHeight * .6,
                width: SizeConfig.screenWidth * .9,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                    AppImage.asset(
                      Assets.images.cash.path,
                      height: SizeConfig.bodyHeight * .17,
                      width: SizeConfig.bodyHeight * .17,
                    ),
                    AppText(
                      text: "${tripModel.user?.name}",
                      maxLines: 3,
                      textSize: 18,
                      fontWeight: FontWeight.bold,
                      textHeight: 1.6,
                      align: TextAlign.center,
                      color: context.colorScheme.primary,
                    ),
                    SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                    AppText(
                      text: context.localizations.driverPaymentConfirmation1,
                      maxLines: 3,
                      textSize: 15,
                      textHeight: 1.6,
                      align: TextAlign.center,
                    ),
                    SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                    AppText(
                      text:
                          "${tripModel.totalPrice} ${context.localizations.iqd}",
                      maxLines: 3,
                      textSize: 25,
                      color: context.colorScheme.primary,
                      align: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),
                    AppText(
                      text: context.localizations.driverPaymentConfirmation2,
                      maxLines: 3,
                      textSize: 15,
                      textHeight: 1.6,
                      align: TextAlign.center,
                    ),
                    const Spacer(),
                    CustomButton(
                        isLoading: state is AcceptPaymentRequestLoading,
                        text: context.localizations.confirm,
                        press: () {
                          context
                              .read<PaymentConfirmationCubit>()
                              .acceptPaymentRequest(
                                  driverAcceptConfirmation: true,
                                  tripId: tripModel.uuid.toString(),
                                  id: tripModel.id ?? 0.0);
                        }),
                    SizedBox(
                      height: SizeConfig.bodyHeight * .04,
                    ),
                    InkWell(
                      onTap: () {
                        context
                            .read<PaymentConfirmationCubit>()
                            .acceptPaymentRequest(
                            driverAcceptConfirmation: false,
                            tripId: tripModel.uuid ?? "",
                            id: tripModel.id ?? 0.0);
                        Future.delayed(
                          const Duration(milliseconds: 600),
                              () {
                            SettingsHelper.contactUsWithPhoneNumber(
                                phoneNumber: context
                                    .read<SettingsBloc>()
                                    .settingsModel!
                                    .firstPhone ??
                                    "");
                          },
                        );
                      },
                      child: AppText(
                        text: context.localizations.driverRejectPayment,
                        color: context.colorScheme.error,
                        maxLines: 2,
                        align: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.bodyHeight * .02,
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
