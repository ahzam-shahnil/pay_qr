// Flutter imports:
import 'package:flutter/material.dart';

class CheckButton extends StatelessWidget {
  const CheckButton(
      {Key? key,
      required this.text,
      this.onPressed,
      required this.icon,
      this.style,
      this.textStyle})
      : super(key: key);
  final String text;
  final Widget icon;
  final void Function()? onPressed;
  final ButtonStyle? style;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: style,
      icon: icon,
      label: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
