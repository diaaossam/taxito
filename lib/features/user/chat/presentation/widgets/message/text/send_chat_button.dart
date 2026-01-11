import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/extensions/validitor_extention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../core/utils/app_size.dart';
import '../../../../../../gen/assets.gen.dart';
import '../../../../../trip/data/models/trip_model.dart';
import '../../../../domain/entities/send_chat_params.dart';
import '../../../bloc/message/message_bloc.dart';

class SendChatButton extends StatefulWidget {
  final TripModel tripModel;
  final GlobalKey<FormBuilderState> formKey;

  const SendChatButton({
    super.key,
    required this.formKey,
    required this.tripModel,
  });

  @override
  State<SendChatButton> createState() => _SendChatButtonState();
}

class _SendChatButtonState extends State<SendChatButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        final bloc = context.read<MessageBloc>();
        return GestureDetector(
          onTap: () {
            if (!widget.formKey.currentState!.saveAndValidate()) {
              return;
            }

            String? msg = widget.formKey.fieldValue("chat");
            widget.formKey.currentState?.fields['chat']?.didChange("");
            if (msg == null) {
              return;
            }
            msg = msg.trim();
            if (msg.isEmpty) {
              return;
            }
            if (msg.isNotEmpty) {
              bloc.sendNewMessage(
                  params: SendChatParams(
                message: msg,
                tripId: widget.tripModel.id ?? 0,
                chatUuid: widget.tripModel.uuid ?? "",
              ));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: context.colorScheme.tertiary),
            child: SvgPicture.asset(
              Assets.icons.send,
              height: SizeConfig.bodyHeight * .035,
            ),
          ),
        );
      },
    );
  }
}
