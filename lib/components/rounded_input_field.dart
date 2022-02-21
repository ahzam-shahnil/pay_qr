// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:pay_qr/config/constants.dart';
import 'text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? textController;
  final int? maxLines;
  final TextInputType? textInputType;
  final Iterable<String>? autofillHints;
  final bool? isEnabled;
  final ScrollController scrollController = ScrollController();
  RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.textController,
    this.maxLines,
    this.textInputType,
    this.autofillHints,
    this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: Scrollbar(
        controller: scrollController,
        trackVisibility: true,
        child: TextField(
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
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
