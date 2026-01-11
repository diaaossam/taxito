import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/auth/presentation/pages/login_screen.dart';
import 'package:taxito/features/auth/presentation/widgets/complete_register_body.dart';
import 'package:taxito/features/location/presentation/cubit/governorate/governorate_bloc.dart';
import 'package:taxito/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../core/extensions/navigation.dart';
import '../../../../core/utils/app_constant.dart';
import '../../../settings/settings_helper.dart';
import '../cubit/complete_register/complete_register_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final bool isUpdate;

  const RegisterScreen(
      {super.key, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          sl<CompleteRegisterBloc>()
            ..add(GetSupplierCategoryEvent()),
        ),
        BlocProvider(
          create: (context) => sl<GovernorateBloc>()..add(GetAllGovernorateEvent()),
        ),
      ],
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) =>
            [
              CustomSliverAppBar(
                showLeading: Navigator.canPop(context),
                actions: [
                  if(isUpdate)
                    BlocConsumer<CompleteRegisterBloc, CompleteRegisterState>(
                      listener: (context, state) {
                        if (state is DeleteUserFailure) {
                          AppConstant.showCustomSnakeBar(
                              context, state.errorMsg, false);
                        } else if (state is DeleteUserSuccess) {
                          context.navigateToAndFinish(const LoginScreen());
                        }
                      },
                      builder: (context, state) {
                        return IconButton(
                          onPressed: () {
                            SettingsHelper().showAppDialog(
                              context: context,
                              isAccept: (value) {
                                if (value) {
                                  context.read<CompleteRegisterBloc>().add(
                                      DeleteAccountEvent());
                                }
                              },
                              title: context.localizations.deleteAccountBody,
                            );
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                        );
                      },
                    ),
                ],
                title: isUpdate
                    ? context.localizations.editProfileInfo
                    : context.localizations.createNewAccount,
              )
            ],
            body: RegisterBody(
              isUpdate: isUpdate,
            )),
      ),
    );
  }
}
