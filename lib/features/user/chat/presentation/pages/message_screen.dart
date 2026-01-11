import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/dependencies/injectable_dependencies.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../trip/data/models/trip_model.dart';
import '../bloc/message/message_bloc.dart';
import '../widgets/message/message_body.dart';

class MessageScreen extends StatelessWidget {
  final TripModel tripModel;

  const MessageScreen({
    super.key,
    required this.tripModel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSupportChat = tripModel.id == null;
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        final shared = sl<SharedPreferences>();
        shared.remove(AppStrings.notifications);
      },
      child: BlocProvider(
          create: (context) =>
              sl<MessageBloc>()..initSocketEvents(tripModel: tripModel,isSupport: isSupportChat),
          child: Scaffold(
              body: MessageBody(
            tripModel: tripModel,
          ))),
    );
  }
}
