// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:

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

  final bool? isEnabled;
  final double? height;
  final ScrollController scrollController = ScrollController();
  RoundedRectangleInputField({
    Key? key,
    required this.hintText,
    this.icon,
    this.onChanged,
    this.textController,
    this.maxLines,
    this.textInputType,
    this.autofillHints,
    this.isEnabled,
    this.textCapitalization = TextCapitalization.none,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      height: height,
      child: TextField(
        textCapitalization: textCapitalization,
        enabled: isEnabled,
        enableIMEPersonalizedLearning: true,
        enableInteractiveSelection: true,
        textInputAction: TextInputAction.next,
        enableSuggestions: true,
        autocorrect: false,
        scrollController: scrollController,
        maxLines: maxLines,
        onChanged: onChanged,
        controller: textController,
        cursorColor: kPrimaryColor,
        keyboardType: textInputType,
        autofillHints: autofillHints,
        style: Theme.of(context).textTheme.headline6?.copyWith(
              fontWeight: FontWeight.normal,
            ),
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
              .headline6
              ?.copyWith(fontWeight: FontWeight.normal),
          hintText: hintText,
          border: InputBorder.none,
        ),
        minLines: 1,
      ),
    );
  }
}
