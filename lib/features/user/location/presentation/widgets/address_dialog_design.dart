import 'package:aslol/core/extensions/app_localizations_extension.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/navigation.dart';
import 'package:aslol/core/utils/app_constant.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/features/location/data/models/response/my_address.dart';
import 'package:aslol/features/location/presentation/cubit/my_address/my_address_cubit.dart';
import 'package:aslol/features/location/presentation/pages/add_address_screen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/custom_app_bar.dart';
import 'package:aslol/widgets/custom_button.dart';
import 'package:aslol/widgets/loading/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/dependencies/injectable_dependencies.dart';
import 'address_list_design.dart';

class AddressDialogDesign extends StatelessWidget {
  final Function(MyAddress) onChoose;
  final bool isDialog;

  const AddressDialogDesign(
      {super.key, required this.onChoose, this.isDialog = true});

  @override
  Widget build(BuildContext context) {
    if (isDialog) {
      return BlocProvider(
        create: (context) => sl<MyAddressCubit>(),
        child: Container(
          width: double.infinity,
          height: SizeConfig.bodyHeight * .8,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: EdgeInsets.symmetric(
              vertical: SizeConfig.bodyHeight * .03,
              horizontal: SizeConfig.screenWidth * .04),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      align: TextAlign.center,
                      text: context.localizations.address,
                      fontWeight: FontWeight.w600,
                      textSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36.h,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: context.colorScheme.onSurface),
                      ),
                      child: const Icon(Icons.close, size: 20),
                    ),
                  ),
                ],
              ),
              BlocConsumer<MyAddressCubit, MyAddressState>(
                listener: (context, state) {
                  if (state is MakeAddressDefaultFailure) {
                    AppConstant.showCustomSnakeBar(context, state.msg, false);
                  } else if (state is MakeAddressDefaultSuccess) {
                    onChoose(state.myAddress);
                    AppConstant.showCustomSnakeBar(context, state.msg, true);
                  }
                },
                builder: (context, state) {
                  if (state is GetMyAddressLoading) {
                    return const Expanded(child: LoadingWidget());
                  } else if (state is GetMyAddressFailure) {
                    return Center(
                      child: AppText(
                        text: state.msg,
                        color: context.colorScheme.error,
                      ),
                    );
                  } else if (getState(state)) {
                    return AddressListDesign(
                      showActions: false,
                      addressCallback: (p0) => context.read<MyAddressCubit>().makeAddressDefault(myAddress: p0),
                      addressList: context.read<MyAddressCubit>().addressList,
                    );
                  } else {
                    return const Center();
                  }
                },
              ),
              BlocBuilder<MyAddressCubit, MyAddressState>(
                builder: (context, state) {
                  return CustomButton(
                      text: context.localizations.addNewAddress,
                      press: () => context.navigateTo(
                            const AddAddressScreen(),
                            callback: (p0) =>
                                context.read<MyAddressCubit>().getMyAddress(),
                          ));
                },
              )
            ],
          ),
        ),
      );
    } else {
      return BlocProvider(
        create: (context) => sl<MyAddressCubit>(),
        child: Scaffold(
          appBar: CustomAppBar(
            title: context.localizations.address,
          ),
          body: Container(
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: EdgeInsets.symmetric(
                vertical: SizeConfig.bodyHeight * .03,
                horizontal: SizeConfig.screenWidth * .04),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<MyAddressCubit, MyAddressState>(
                  listener: (context, state) {
                    if (state is MakeAddressDefaultFailure) {
                      AppConstant.showCustomSnakeBar(context, state.msg, false);
                    } else if (state is MakeAddressDefaultSuccess) {
                      onChoose(state.myAddress);
                      AppConstant.showCustomSnakeBar(context, state.msg, true);
                    } else if (state is DeleteAddressSuccess) {
                      AppConstant.showCustomSnakeBar(context, state.msg, false);
                    }
                  },
                  builder: (context, state) {
                    if (state is GetMyAddressLoading) {
                      return const Expanded(child: LoadingWidget());
                    } else if (state is GetMyAddressFailure) {
                      return Center(
                        child: AppText(
                          text: state.msg,
                          color: context.colorScheme.error,
                        ),
                      );
                    } else if (getState(state)) {
                      return AddressListDesign(
                        showActions: true,
                        addressCallback: (p0) {
                          context
                              .read<MyAddressCubit>()
                              .makeAddressDefault(myAddress: p0);
                        },
                        addressList: context.read<MyAddressCubit>().addressList,
                      );
                    } else {
                      return const Center();
                    }
                  },
                ),
                BlocBuilder<MyAddressCubit, MyAddressState>(
                  builder: (context, state) {
                    return CustomButton(
                        text: context.localizations.addNewAddress,
                        press: () => context.navigateTo(const AddAddressScreen(),
                              callback: (p0) =>
                                  context.read<MyAddressCubit>().getMyAddress(),
                            ));
                  },
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  bool getState(MyAddressState state) {
    return state is GetMyAddressSuccess ||
        state is MakeAddressDefaultLoading ||
        state is MakeAddressDefaultSuccess ||
        state is DeleteAddressSuccess ||
        state is DeleteAddressFailure ||
        state is DeleteAddressLoading;
  }
}
