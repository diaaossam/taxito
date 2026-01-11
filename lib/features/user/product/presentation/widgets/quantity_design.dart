import 'package:aslol/core/extensions/color_extensions.dart';
import 'package:aslol/gen/assets.gen.dart';
import 'package:aslol/widgets/app_text.dart';
import 'package:aslol/widgets/image_picker/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuantityDesign extends StatefulWidget {
  final int count;
  final Function(Map<String, dynamic>) callback;
  final bool isProductDetails;
  final bool isCard;
  final bool? isCart;
  final double? buttonSize;

  const QuantityDesign({
    super.key,
    this.count = 0,
    this.buttonSize = 0,
    this.isCart = false,
    required this.callback,
    required this.isProductDetails,
    this.isCard = false,
  });

  @override
  State<QuantityDesign> createState() => QuantityDesignState();
}

class QuantityDesignState extends State<QuantityDesign> {
  int count = 0;

  @override
  void initState() {
    count = widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 4),
      curve: Curves.fastOutSlowIn,
      decoration: BoxDecoration(
          color: context.colorScheme.onTertiaryFixed,
          border: widget.isProductDetails || widget.isCart == true
              ? Border.all(color: context.colorScheme.outline)
              : null,
          borderRadius: BorderRadius.circular(10)),
      child: count == 0
          ? InkWell(
               onTap: () {
          setState(() => count++);
          widget.callback(
              {"isIncrease": true, "count": count, "isAdd": true});
        },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: SvgPicture.asset(
                  Assets.icons.add,
                  color: Colors.black,
                  height: 18,
                ),
              ),
            )
          : widget.isCart == true
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 25),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: () {
                            // In cart: allow decrement to 0 which will delete the item
                            // In product details: minimum quantity is 1
                            if (widget.isProductDetails && count == 1) {
                              return;
                            }
                            setState(() => count--);
                            widget.callback({
                              "isIncrease": false,
                              "count": count,
                              "isAdd": false,
                              "isDelete": count == 0,
                              // Flag for deletion when count reaches 0
                            });
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: 10.w, start: 10.w, top: 5, bottom: 5),
                            child: SvgPicture.asset(
                              Assets.icons.minus,
                              height: widget.buttonSize ?? 18,
                              colorFilter: const ColorFilter.mode(
                                  Colors.black, BlendMode.srcIn),
                            ),
                          )),
                      AppText(
                        text: "$count",
                        textSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => count++);
                          widget.callback({
                            "isIncrease": true,
                            "count": count,
                            "isAdd": false
                          });
                        },
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              end: 10.w, start: 10.w, top: 5, bottom: 5),
                          child: SvgPicture.asset(
                            Assets.icons.add,
                            height: widget.buttonSize ?? 18,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              : Padding(
                  padding: widget.isProductDetails
                      ? const EdgeInsets.symmetric(vertical: 5)
                      : EdgeInsets.zero,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (widget.isProductDetails && count == 1) {
                              return;
                            }
                            setState(() => count--);
                            widget.callback({
                              "isIncrease": false,
                              "count": count,
                              "isAdd": false,
                              "isDelete": count == 0,
                              // Flag for deletion when count reaches 0
                            });
                          },
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                                end: 4.w, start: 4.w, top: 5, bottom: 5),
                            child: SvgPicture.asset(
                              Assets.icons.minus,
                              height: widget.buttonSize ?? 18,
                              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            ),
                          )),
                      AppText(
                        text: "$count",
                        textSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() => count++);
                          widget.callback({
                            "isIncrease": true,
                            "count": count,
                            "isAdd": false
                          });
                        },
                        child: Padding(
                          padding: EdgeInsetsDirectional.only(
                              end: 4.w, start: 4.w, top: 5, bottom: 5),
                          child: SvgPicture.asset(
                            Assets.icons.add,
                            height: widget.buttonSize ?? 18,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }

  void resetCount() {
    setState(() => count = 0);
  }
}
