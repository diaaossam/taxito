import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/features/main/presentation/pages/main_layout.dart';
import 'package:aslol/features/trip/data/models/trip_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../core/utils/app_size.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../widgets/app_text.dart';
import '../../../../../widgets/custom_button.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import '../../../../../widgets/loading/loading_widget.dart';
import '../../bloc/trip_payment_user/trip_payment_user_cubit.dart';

class PendingPaymentDialog extends StatelessWidget {
  final GlobalKey globalKey;
  final TripModel tripModel;
  final Map<String, dynamic> map;

  const PendingPaymentDialog({
    super.key,
    required this.tripModel,
    required this.map,
    required this.globalKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<TripPaymentUserCubit>()..initSocket(tripId: tripModel.uuid ?? ""),
      child: BlocConsumer<TripPaymentUserCubit, TripPaymentUserState>(
        listener: (context, state) {
          if (state is SendPaymentRequestFailure) {
            AppConstant.showCustomSnakeBar(context, state.msg, false);
          } else if (state is DriverSendConfirmPaymentState) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              context.navigateToAndFinish(const MainLayout());
            }
          }
        },
        builder: (context, state) {
          final bloc = context.read<TripPaymentUserCubit>();
          return AlertDialog(
            key: globalKey,
            content: PopScope(
              canPop: false,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30.h),
                height: SizeConfig.bodyHeight * .6,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeConfig.bodyHeight * .02),
                    AppImage.asset(
                      Assets.images.cash.path,
                      height: SizeConfig.bodyHeight * .17,
                      width: SizeConfig.bodyHeight * .17,
                    ),
                    SizedBox(height: SizeConfig.bodyHeight * .02),
                    AppText(
                      text: bloc.currentPaymentState == 0
                          ? context.localizations.payToDriver
                          : context.localizations.waitingDriverToAccept,
                      maxLines: 3,
                      textSize: 15,
                      textHeight: 1.6,
                      align: TextAlign.center,
                    ),
                    SizedBox(height: SizeConfig.bodyHeight * .02),
                    AppText(
                      text:
                          "${tripModel.totalPrice} ${context.localizations.iqd}",
                      maxLines: 3,
                      textSize: 20,
                      color: context.colorScheme.primary,
                      align: TextAlign.center,
                      fontWeight: FontWeight.bold,
                    ),
                    const Spacer(),
                    if (bloc.currentPaymentState == 0)
                      CustomButton(
                        isLoading: state is SendPaymentRequestLoading,
                        text: context.localizations.send,
                        press: () {
                          context
                              .read<TripPaymentUserCubit>()
                              .sendPaymentRequestToDriver(
                                tripId: tripModel.uuid ?? "",
                                id: tripModel.id ?? 0,
                                paymentMethod: tripModel.paymentMethod!,
                              );
                        },
                      )
                    else
                      const LoadingWidget(),
                    SizedBox(height: SizeConfig.bodyHeight * .04),
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
