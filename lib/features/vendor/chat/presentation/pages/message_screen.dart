import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../../core/utils/app_strings.dart';
import '../bloc/message/message_bloc.dart';
import '../widgets/message/message_body.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        final shared = sl<SharedPreferences>();
        shared.remove(AppStrings.notifications);
      },
      child: BlocProvider(
        create: (context) => sl<MessageBloc>(),
        child: Scaffold(body: MessageBody()),
      ),
    );
  }
}
