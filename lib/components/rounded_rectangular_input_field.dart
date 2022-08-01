// ignore_for_file: public_member_api_docs, sort_constructors_first
// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../config/app_constants.dart';
import 'text_field_container.dart';

class RoundedRectangleInputField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textController;
  final int? maxLines;
  final TextCapitalization textCapitalization;
  final TextInputType? textInputType;
  final Iterable<String>? autofillHints;
  final bool? isAutoFocus;
  final bool? isEnabled;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final double? height;
  final Color? color;
  final ScrollController scrollController = ScrollController();
  RoundedRectangleInputField({
    Key? key,
    required this.hintText,
    this.icon,
    this.onChanged,
    this.textController,
    this.maxLines,
    this.textCapitalization = TextCapitalization.none,
    this.textInputType,
    this.autofillHints,
    this.isAutoFocus,
    this.isEnabled,
    this.onSubmitted,
    this.height,
    this.textInputAction,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      height: height,
      backColor: color,
      child: TextField(
        textCapitalization: textCapitalization,
        enabled: isEnabled,
        onSubmitted: onSubmitted,
        enableIMEPersonalizedLearning: true,
        enableInteractiveSelection: true,
        textInputAction: textInputAction ?? TextInputAction.next,
        enableSuggestions: true,
        autocorrect: false,
        autofocus: isAutoFocus ?? false,
        scrollController: scrollController,
        maxLines: maxLines,
        onChanged: onChanged,
        controller: textController,
        cursorColor: kPrimaryColor,
        keyboardType: textInputType,
        autofillHints: autofillHints,
        style: Theme.of(context)
            .textTheme
            .bodyLarge
            ?.copyWith(fontWeight: FontWeight.normal, color: kScanBackColor),
        decoration: InputDecoration(
          icon: icon != null
              ? Icon(
                  icon,
                  color: Colors.white,
                )
              : null,
          // hintStyle: Theme.of(context).textTheme.headline6?.copyWith(
          //     fontWeight: FontWeight.normal,
          //     fontSize: Get.size.shortestSide * 0.035),
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.normal, color: kScanBackColor),
          hintText: hintText,
          border: InputBorder.none,
        ),
        minLines: 1,
      ),
    );
  }
}
