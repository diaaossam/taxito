import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxito/config/theme/theme_helper.dart';
import 'package:taxito/core/extensions/color_extensions.dart';
import 'package:taxito/widgets/app_text.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.controller,
    this.initialValue,
    this.focusNode,
    this.decoration,
    this.keyboardType,
    this.textCapitalization,
    this.style,
    this.strutStyle,
    this.textDirection,
    this.textAlign,
    this.textAlignVertical,
    this.autofocus,
    this.readOnly,
    this.showCursor,
    this.obscuringCharacter,
    this.obscureText,
    this.autocorrect,
    this.smartDashesType,
    this.smartQuotesType,
    this.enableSuggestions,
    this.maxLengthEnforcement,
    this.minLines,
    this.expands,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.onTapOutside,
    this.onEditingComplete,
    this.onSaved,
    this.onSubmitted,
    this.validator,
    this.inputFormatters,
    this.cursorWidth,
    this.cursorHeight,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.scrollPadding,
    this.selectionControls,
    this.buildCounter,
    this.scrollPhysics,
    this.autofillHints,
    this.autovalidateMode,
    this.scrollController,
    this.restorationId,
    this.mouseCursor,
    this.contextMenuBuilder,
    this.magnifierConfiguration,
    this.dragStartBehavior,
    this.contentInsertionConfiguration,
    this.description,
    this.label,
    this.suffixIcon,
    this.title,
    this.name,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.disabledBorder,
    this.border,
    this.fillColor,
    this.enabled = true,
    this.enableInteractiveSelection = true,
    this.filled = true,
    this.maxLines = 1,
    this.titleStyle,
    this.textInputAction = TextInputAction.next,
    this.valueTransformer,
    this.isMobileWidget = false,

    ///Custom Parameter
    this.hintText,
    this.hintStyle,
    this.hintMaxLines,
    this.hintTextDirection,
    this.alignLabelWithHint,
    this.margin,
    super.key,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.height,
    this.appKey,
    this.elevation = 2,
    this.isDense = false,
    this.constraints,
  });

  final GlobalKey<FormBuilderFieldState>? appKey;
  final TextEditingController? controller;
  final String? initialValue;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final bool isMobileWidget;

  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final TextAlignVertical? textAlignVertical;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? constraints;
  final bool? autofocus;
  final bool? readOnly;
  final bool? showCursor;
  final String? obscuringCharacter;
  final bool? obscureText;
  final bool? autocorrect;
  final SmartDashesType? smartDashesType;
  final SmartQuotesType? smartQuotesType;
  final bool? enableSuggestions;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final int maxLines;

  final int? minLines;
  final bool? expands;
  final int? maxLength;
  final ValueChanged<String?>? onChanged;
  final GestureTapCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onEditingComplete;
  final FormFieldSetter<String>? onSaved;
  final FormFieldSetter<String>? onSubmitted;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final bool enabled;
  final double? cursorWidth;
  final double? cursorHeight;
  final Radius? cursorRadius;
  final Color? cursorColor;
  final Brightness? keyboardAppearance;
  final EdgeInsets? scrollPadding;
  final bool enableInteractiveSelection;
  final TextSelectionControls? selectionControls;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final Iterable<String>? autofillHints;
  final AutovalidateMode? autovalidateMode;
  final ScrollController? scrollController;
  final String? restorationId;
  final MouseCursor? mouseCursor;
  final EditableTextContextMenuBuilder? contextMenuBuilder;
  final TextMagnifierConfiguration? magnifierConfiguration;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? border;
  final TextStyle? titleStyle;

  final DragStartBehavior? dragStartBehavior;
  final ContentInsertionConfiguration? contentInsertionConfiguration;
  final EdgeInsets? margin;
  final String? description;
  final String? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? title;
  final double elevation;
  final String? name;
  final bool filled;
  final Color? fillColor;
  final dynamic Function(String? value)? valueTransformer;

  ///Custom Parameter
  ///when pass [decoration] this will be ignore [hintText,hintStyle,hintMaxLines,hintTextDirection,alignLabelWithHint]
  final String? hintText;
  final TextStyle? hintStyle;
  final int? hintMaxLines;
  final TextDirection? hintTextDirection;
  final bool? alignLabelWithHint;
  final bool? isDense;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (title != null) ...{
            AppText(
              text: title!,
              fontWeight: FontWeight.w500,
              textSize: 13,
            ),
            12.verticalSpace
          },
          isMobileWidget
              ? Directionality(
                  textDirection: textDirection ?? TextDirection.rtl,
                  child: _buildFormBuilder(context: context),
                )
              : _buildFormBuilder(context: context)
        ],
      ),
    );
  }

  Widget _buildFormBuilder({required BuildContext context}) {
    return FormBuilderTextField(
      key: appKey,
      valueTransformer: valueTransformer,
      name: name ?? label ?? '',
      controller: controller,
      initialValue: initialValue,
      focusNode: focusNode,
      onSubmitted: onSubmitted,
      decoration: decoration ??
          InputDecoration(
            isDense: true,
            counter: const SizedBox.shrink(),
            counterStyle: const TextStyle(height: 0),
            label: label != null ? AppText(text: label!) : null,
            hintText: hintText,
            hintStyle: ThemeHelper().hintTFFTextStyle(),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            hintMaxLines: hintMaxLines,
            hintTextDirection: hintTextDirection,
            contentPadding:
                REdgeInsetsDirectional.only(start: 16, top: 16, bottom: 10),
            fillColor: fillColor ?? context.colorScheme.surface,
            focusColor: context.colorScheme.inversePrimary,
            alignLabelWithHint: alignLabelWithHint,
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(
                maxHeight: 40.h, minHeight: 10.h, minWidth: 40.w),
            constraints: constraints ?? BoxConstraints(minHeight: 48.h),
            prefixIconConstraints: prefixIconConstraints ??
                BoxConstraints(
                    maxHeight: 40.h, minHeight: 10.h, minWidth: 40.w),
            prefixIcon: prefixIcon,
            filled: true,
            border: ThemeHelper().buildMainTffBorder(context: context),
            disabledBorder: ThemeHelper().buildMainTffBorder(context: context),
            errorBorder: ThemeHelper().buildErrorBorder(),
            enabledBorder: enabledBorder ??
                ThemeHelper().buildMainTffBorder(context: context),
            focusedBorder: focusedBorder ??
                ThemeHelper().buildMainTffBorder(context: context),
          ),
      keyboardType: keyboardType,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textInputAction: textInputAction,
      style: ThemeHelper().mainTFFTextStyle(context, isEnabled: true),
      strutStyle: strutStyle,
      textAlign: textAlign ?? TextAlign.start,
      textAlignVertical: textAlignVertical,
      autofocus: autofocus ?? false,
      readOnly: readOnly ?? false,
      showCursor: showCursor,
      obscuringCharacter: obscuringCharacter ?? '•',
      obscureText: obscureText ?? false,
      autocorrect: autocorrect ?? true,
      smartDashesType: smartDashesType,
      smartQuotesType: smartQuotesType,
      enableSuggestions: enableSuggestions ?? true,
      maxLengthEnforcement: maxLengthEnforcement,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands ?? false,
      maxLength: maxLength,
      onChanged: onChanged,
      onTap: onTap,
      onTapOutside: onTapOutside,
      onEditingComplete: onEditingComplete,
      onSaved: onSaved,
      validator: validator,
      inputFormatters: inputFormatters,
      enabled: enabled,
      cursorWidth: cursorWidth ?? 2.0,
      cursorHeight: cursorHeight,
      cursorRadius: cursorRadius,
      cursorColor: cursorColor,
      keyboardAppearance: keyboardAppearance,
      enableInteractiveSelection: enableInteractiveSelection,
      buildCounter: buildCounter,
      scrollPhysics: scrollPhysics,
      autofillHints: autofillHints,
      autovalidateMode: autovalidateMode,
      scrollController: scrollController,
      restorationId: restorationId,
      mouseCursor: mouseCursor,
      magnifierConfiguration: magnifierConfiguration,
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
      contentInsertionConfiguration: contentInsertionConfiguration,
    );
  }
}
