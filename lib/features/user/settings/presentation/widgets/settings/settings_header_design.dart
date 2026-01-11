import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/auth/data/models/response/user_model_helper.dart';
import 'package:aslol/features/payment/presentation/pages/wallet_screen.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../order/order_helper.dart';
import '../../../../payment/presentation/bloc/wallet/wallet_cubit.dart';

class SettingsHeaderDesign extends StatelessWidget {
  const SettingsHeaderDesign({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<WalletCubit>()..getBalance(),
      child: BlocBuilder<WalletCubit, WalletState>(
        builder: (context, state) {
          return SizedBox(
            height: SizeConfig.bodyHeight * .14,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    context.navigateTo(
                      const WalletScreen(),
                      callback: (p0) {
                        context.read<WalletCubit>().getBalance();
                      },
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: context.colorScheme.onPrimaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        AppImage.asset(
                          Assets.images.wallet.path,
                          height: SizeConfig.bodyHeight * .07,
                          width: SizeConfig.bodyHeight * .07,
                        ),
                        10.verticalSpace,
                        AppText(text: context.localizations.wallet1)
                      ],
                    ),
                  ),
                ),
                4.horizontalSpace,
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      Clipboard.setData(ClipboardData(
                              text:
                                  UserDataService().getUserData()?.code ?? ""))
                          .then(
                        (value) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  context.localizations.copiedToClipboard)));
                        },
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: context.colorScheme.onPrimaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          2.verticalSpace,
                          Row(
                            children: [
                              AppImage.asset(
                                Assets.images.coins.path,
                                height: SizeConfig.bodyHeight * .04,
                                width: SizeConfig.bodyHeight * .04,
                              ),
                              5.horizontalSpace,
                              AppText(
                                text:
                                    "${context.localizations.currentBalance}:    ${state is GetWalletBalanceSuccess ? "${formatPrice(price: state.balance.toString())} ${context.localizations.iqd}" : context.localizations.balance}",
                                fontWeight: FontWeight.w500,
                                textSize: 11,
                              ),
                            ],
                          ),

                          8.verticalSpace,
                          Row(
                            children: [
                              AppImage.asset(
                                Assets.images.travelsRecord.path,
                                height: 20.w,
                                width: 20.w,
                              ),
                              5.horizontalSpace,
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text:
                                        "${context.localizations.freePointsCount}: ${formatPrice(price: UserDataService().getUserData()?.points)}",
                                    fontWeight: FontWeight.w500,
                                    textSize: 9,
                                  ),
                                  8.verticalSpace,
                                  Row(
                                    children: [
                                      AppText(
                                        text:
                                            "#${UserDataService().getUserData()?.code}",
                                        fontWeight: FontWeight.w500,
                                        textSize: 9,
                                      ),
                                      4.horizontalSpace,
                                      const Icon(
                                        Icons.copy,
                                        size: 10,
                                      ),
                                      4.horizontalSpace,
                                      AppText(
                                        text: context
                                            .localizations.freePointsCount1,
                                        fontWeight: FontWeight.w500,
                                        textSize: 9,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget buildHeaderItem(
    {required String title,
    required String image,
    required VoidCallback onTap,
    required BuildContext context}) {
  return Container(
    height: SizeConfig.bodyHeight * .1,
    width: SizeConfig.bodyHeight * .14,
    padding: EdgeInsets.all(8.r),
    decoration: BoxDecoration(
      color: context.colorScheme.onPrimaryContainer,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [AppImage.asset(image), 10.verticalSpace, AppText(text: title)],
    ),
  );
}
