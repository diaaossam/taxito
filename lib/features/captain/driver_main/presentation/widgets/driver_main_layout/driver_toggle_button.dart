import 'package:taxito/core/extensions/app_localizations_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../../core/bloc/socket/socket_cubit.dart';
import '../../../../../../core/enum/choose_enum.dart';
import '../../../../../../widgets/app_text.dart';
import '../../../../../common/models/user_model_helper.dart';
import '../../cubit/availitiablity/availitiablity_cubit.dart';

class DriverToggleButton extends StatefulWidget {
  final Function(ChooseEnum) callbackAvailability;

  const DriverToggleButton({
    super.key,
    required this.callbackAvailability,
  });

  @override
  State<DriverToggleButton> createState() => _DriverToggleButtonState();
}

class _DriverToggleButtonState extends State<DriverToggleButton> {
  ChooseEnum chooseEnum = ChooseEnum.no;
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    if(context.read<SocketCubit>().socketService.isConnected()){
      init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocketCubit, SocketState>(
      listener: (context, socketState) {
        if (socketState is SocketConnected && !_hasInitialized) {
          _hasInitialized = true;
          init();
        }
      },
      child: BlocProvider(
        create: (context) => sl<AvailitiablityCubit>(),
        child: BlocConsumer<AvailitiablityCubit, AvailitiablityState>(
          listener: (context, state) {
            if (state is ChangeAvailitiablitySuccess) {
              UserDataService().reloadUserData(context: context);
            }
          },
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CupertinoSwitch(
                  value: chooseEnum == ChooseEnum.yes,
                  onChanged: (value) async {
                    await context
                        .read<AvailitiablityCubit>()
                        .toggleDriverAvailibtiy();
                    setState(() {
                      if (chooseEnum == ChooseEnum.yes) {
                        chooseEnum = ChooseEnum.no;
                      } else {
                        chooseEnum = ChooseEnum.yes;
                      }
                    });
                    widget.callbackAvailability(chooseEnum);
                  },
                ),
                AppText(
                    text: chooseEnum == ChooseEnum.yes
                        ? context.localizations.available
                        : context.localizations.notAvailable),
              ],
            );
          },
        ),
      ),
    );
  }

  void init() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        chooseEnum = UserDataService().getUserData()?.isAvailableEnum ?? ChooseEnum.no;
        widget.callbackAvailability(chooseEnum);
        setState(() {});
      },
    );
  }
}
