// Flutter imports:
import 'package:flutter/material.dart';

import '../config/app_constants.dart';


class SquareButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color, textColor;
  final double width;
  final IconData? icon;

  const SquareButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
    required this.width,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.07),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color,
      ),
      width: width,
      child: newTextIconButton(),
    );
  }

  Widget newTextIconButton() {
    return TextButton.icon(
      onPressed: press,
      icon: Icon(icon),
      label: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      style: TextButton.styleFrom(
        primary: color,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        textStyle: TextStyle(color: textColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
