import 'package:flutter/material.dart';
import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/core/utils/app_size.dart';
import 'package:aslol/widgets/app_text.dart';
import 'question_arrow.dart';

class CustomExpandedWidget extends StatefulWidget {
  final String title;
  final String body;

  const CustomExpandedWidget(
      {super.key, required this.body, required this.title});

  @override
  State<CustomExpandedWidget> createState() => _CustomExpandedWidgetState();
}

class _CustomExpandedWidgetState extends State<CustomExpandedWidget>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final Tween<double> _sizeTween;
  bool _isExpanded = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _sizeTween = Tween(begin: 0, end: 1);
    super.initState();
  }

  void _expandOnChanged() {
    _isExpanded = !_isExpanded;
    _isExpanded ? _controller.forward() : _controller.reverse();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _expandOnChanged,
          child: Row(
            children: [
              Expanded(
                  child: AppText(
                text: widget.title,
                fontWeight: FontWeight.w700,
                maxLines: 2,
                textSize: 18,
                color: _isExpanded ? context.colorScheme.primary : null,
              )),
              QuestionArrowWidget(
                isActive: _isExpanded,
              ),
            ],
          ),
        ),
        SizeTransition(
          sizeFactor: _sizeTween.animate(_animation),
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: SizeConfig.screenWidth * .02),
            child: AppText(
              text: widget.body,
              fontWeight: FontWeight.bold,
              maxLines: 100,
              textSize: 14,
            ),
          ),
        ),
        SizedBox(height: SizeConfig.bodyHeight * .04),
      ],
    );
  }
}
