import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/utils/app_constant.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/payment/presentation/bloc/balance/balance_cubit.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/dependencies/injectable_dependencies.dart';

class AddBalanceDailOgDesign extends StatefulWidget {
  const AddBalanceDailOgDesign({super.key});

  @override
  State<AddBalanceDailOgDesign> createState() => _AddBalanceDailOgDesignState();
}

class _AddBalanceDailOgDesignState extends State<AddBalanceDailOgDesign> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BalanceCubit>(),
      child: Dialog(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          height: SizeConfig.bodyHeight * .4,
          width: SizeConfig.screenWidth,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Scaffold(
              body: Padding(
                padding: screenPadding(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: SizeConfig.bodyHeight * .04,
                    ),
                    AppText(
                      text: context.localizations.addBalance,
                      textSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    SizedBox(
                      height: SizeConfig.bodyHeight * .04,
                    ),
                    CustomTextFormField(
                      hintText: context.localizations.addBalanceHint,
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(() => this.value = value),
                    ),
                    SizedBox(
                      height: SizeConfig.bodyHeight * .04,
                    ),
                    BlocConsumer<BalanceCubit, BalanceState>(
                      listener: (context, state) {
                        if(state is AddBalanceSuccess){
                          Navigator.pop(context,true);
                          AppConstant.showCustomSnakeBar(context, context.localizations.balanceAddedSuccessfully, true);
                        } if(state is AddBalanceFailure){
                          AppConstant.showCustomSnakeBar(context, state.msg, true);
                        }
                      },
                      builder: (context, state) {
                        return CustomButton(
                            isLoading: state is AddBalanceLoading,
                            isActive: value != null,
                            text: context.localizations.addBalance,
                            press: () => context
                                .read<BalanceCubit>()
                                .addBalance(balance: num.parse(value.toString())));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
