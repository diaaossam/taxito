import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/core/utils/app_size.dart';
import 'package:taxito/features/user/payment/data/models/transaction_model.dart';
import 'package:taxito/features/user/payment/presentation/bloc/wallet/wallet_cubit.dart';
import 'package:taxito/gen/assets.gen.dart';
import 'package:taxito/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../../../widgets/image_picker/app_image.dart';
import 'add_balance_dalig_design.dart';
import 'transaction_item.dart';

class MyWalletBody extends StatelessWidget {
  const MyWalletBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WalletCubit, WalletState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: screenPadding(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: SizeConfig.bodyHeight * .02),
              InkWell(
                onTap: () async {
                  final response = await showDialog(
                    context: context,
                    builder: (context) => const AddBalanceDailOgDesign(),
                  );
                  if (response == true) {
                    context.read<WalletCubit>().pagingController.refresh();
                    context.read<WalletCubit>().getBalance();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.screenWidth * .03,
                    vertical: SizeConfig.bodyHeight * .02,
                  ),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      AppImage.asset(
                        Assets.images.wallet.path,
                        height: SizeConfig.bodyHeight * .1,
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text:
                                  "${context.read<WalletCubit>().currentBalance} ${context.localizations.iqd}",
                              color: context.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              textSize: 18,
                            ),
                            20.verticalSpace,
                            AppText(
                              text: context.localizations.wallet,
                              color: context.colorScheme.shadow,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ),
                      10.verticalSpace,
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: context.colorScheme.primary,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          10.verticalSpace,
                          AppText(
                            text: context.localizations.addBalance,
                            textSize: 10,
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              20.verticalSpace,
              AppText(
                text: context.localizations.transactionHistory,
                fontWeight: FontWeight.bold,
                textSize: 15,
              ),
              20.verticalSpace,
              Expanded(
                child: PagedListView(
                  pagingController: context
                      .read<WalletCubit>()
                      .pagingController,
                  builderDelegate: PagedChildBuilderDelegate(
                    noItemsFoundIndicatorBuilder: (context) {
                      return Opacity(
                        opacity: 0.5,
                        child: Column(
                          children: [
                            SizedBox(height: SizeConfig.bodyHeight * .2),
                            AppImage.asset(
                              Assets.images.wallet.path,
                              height: SizeConfig.bodyHeight * .2,
                            ),
                            20.verticalSpace,
                            AppText.hint(
                              text: context.localizations.noTransactionsFound,
                              textSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      );
                    },
                    itemBuilder: (context, TransactionModel item, index) {
                      return TransactionItem(transactionModel: item);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
