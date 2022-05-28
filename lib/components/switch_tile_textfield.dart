// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'rounded_rectangular_input_field.dart';

class SwitchTileTextField extends StatelessWidget {
  final ValueNotifier<bool> controller;
  final TextEditingController textController;
  final String hintText;
  final bool isInvert;
  const SwitchTileTextField({
    Key? key,
    required this.controller,
    required this.textController,
    required this.hintText,
    this.isInvert = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (_, bool value, __) {
        return !isInvert
            ? value
                ? RoundedRectangleInputField(
                    hintText: hintText,
                    textCapitalization: TextCapitalization.sentences,
                    textInputType: TextInputType.text,
                    textController: textController,
                  )
                : const SizedBox()
            : value
                ? const SizedBox()
                : RoundedRectangleInputField(
                    hintText: hintText,
                    textCapitalization: TextCapitalization.sentences,
                    textInputType: TextInputType.text,
                    textController: textController,
                  );
      },
    );
  }
}
