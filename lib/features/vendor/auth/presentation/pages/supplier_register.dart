import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxito/core/enum/user_type.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/extensions/app_localizations_extension.dart';
import '../../../../../core/extensions/navigation.dart';
import '../../../../../core/utils/app_constant.dart';
import '../../../../../widgets/custom_sliver_app_bar.dart';
import '../../../../captain/auth/presentation/pages/login_screen.dart';
import '../../../../captain/settings/settings_helper.dart';
import '../../../location/presentation/cubit/governorate/governorate_bloc.dart';
import '../cubit/complete_register/complete_register_bloc.dart';
import '../widgets/complete_register_body.dart';

class SupplierRegisterScreen extends StatelessWidget {
  final bool isUpdate;

  const SupplierRegisterScreen({super.key, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<CompleteRegisterBloc>()..add(GetSupplierCategoryEvent()),
        ),
        BlocProvider(
          create: (context) =>
              sl<GovernorateBloc>()..add(GetAllGovernorateEvent()),
        ),
      ],
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CustomSliverAppBar(
              showLeading: Navigator.canPop(context),
              actions: [
                if (isUpdate)
                  BlocConsumer<CompleteRegisterBloc, CompleteRegisterState>(
                    listener: (context, state) {
                      if (state is DeleteUserFailure) {
                        AppConstant.showCustomSnakeBar(
                          context,
                          state.errorMsg,
                          false,
                        );
                      } else if (state is DeleteUserSuccess) {
                        context.navigateToAndFinish(
                          const LoginScreen(userType: UserType.supplier),
                        );
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
                                  DeleteAccountEvent(),
                                );
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
            ),
          ],
          body: RegisterBody(isUpdate: isUpdate),
        ),
      ),
    );
  }
}
