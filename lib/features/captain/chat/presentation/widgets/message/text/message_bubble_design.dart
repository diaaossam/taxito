import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import '../../../../../../common/models/trip_model.dart';
import '../../../../../../../core/utils/app_size.dart';
import '../../../../../../../widgets/app_text.dart';
import '../../../../data/models/message_model.dart';

class MessageBubbleDesign extends StatelessWidget {
  final MessageModel messageModel;
  final TripModel tripModel;

  const MessageBubbleDesign({
    super.key,
    required this.messageModel,
    required this.tripModel,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSender = messageModel.sendBy == "driver";
    return Align(
      alignment: isSender
          ? AlignmentDirectional.topStart
          : AlignmentDirectional.topEnd,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: isSender
                    ? const BorderRadiusDirectional.only(
                        topStart: Radius.circular(12),
                        topEnd: Radius.circular(12),
                        bottomStart: Radius.circular(4),
                        bottomEnd: Radius.circular(12),
                      )
                    : const BorderRadiusDirectional.only(
                        topStart: Radius.circular(12),
                        topEnd: Radius.circular(12),
                        bottomStart: Radius.circular(12),
                        bottomEnd: Radius.circular(4),
                      ),
                color: isSender
                    ? context.colorScheme.primary
                    : context.colorScheme.shadow.withValues(alpha: 0.1),
              ),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * .7,
              ),
              padding: EdgeInsets.symmetric(
                vertical: SizeConfig.bodyHeight * .01,
                horizontal: SizeConfig.screenWidth * .02,
              ),
              child: AppText(
                text: messageModel.message ?? "",
                color: isSender ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
