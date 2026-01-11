import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_size.dart';
import '../../../../driver_trip/data/models/trip_model.dart';
import 'custom_chat_text_form_field.dart';
import 'text/send_chat_button.dart';

class MessageBottomNav extends StatefulWidget {
  final TripModel tripModel;

  const MessageBottomNav({
    super.key,
    required this.tripModel,
  });

  @override
  State<MessageBottomNav> createState() => _MessageBottomNavState();
}

class _MessageBottomNavState extends State<MessageBottomNav> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: SizeConfig.bodyHeight * .025,
          top: SizeConfig.bodyHeight * .015,
          right: SizeConfig.screenWidth * .02,
          left: SizeConfig.screenWidth * .02),
      child: FormBuilder(
          key: _formKey,
          child: Row(children: [
            SendChatButton(
              tripModel: widget.tripModel,
              formKey: _formKey,
            ),
            8.horizontalSpace,
            CustomChatTextField(
              onChange: (p0) {
                if (p0.isEmpty) {
                  setState(() => isActive = false);
                } else {
                  setState(() => isActive = true);
                }
              },
            )
          ])),
    );
  }
}
