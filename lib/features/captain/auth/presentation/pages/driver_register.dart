import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:taxito/features/captain/start/presentation/pages/welcome_screen.dart';
import 'package:taxito/widgets/custom_sliver_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/extensions/navigation.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../settings/settings_helper.dart';
import '../cubit/complete_register/complete_register_bloc.dart';
import '../widgets/complete_register_pages/complete_register_body.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  final bool isUpdate;
  final String phone;

  const RegisterScreen({
    super.key,
    required this.isUpdate,
    required this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CompleteRegisterBloc>(),
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) =>
          [
            CustomSliverAppBar(
              actions: [
                if(isUpdate)
                  BlocConsumer<CompleteRegisterBloc, CompleteRegisterState>(
                    listener: (context, state) {
                      if (state is DeleteUserFailure) {
                        AppConstant.showCustomSnakeBar(
                            context, state.errorMsg, false);
                      } else if (state is DeleteUserSuccess) {
                        context.navigateToAndFinish(const WelcomeScreen());
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
              showLeading: Navigator.canPop(context),
              title: isUpdate
                  ? context.localizations.editProfileInfo
                  : context.localizations.createNewAccount,
            ),
          ],
          body: CompleteRegisterBody(isUpdate: isUpdate),
        ),
      ),
    );
  }
}
