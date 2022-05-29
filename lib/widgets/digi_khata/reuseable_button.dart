import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final VoidCallback? onpress;
  final Color? color;
  const ReusableButton({
    Key? key,
    required this.text,
    this.onpress,
    this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onpress,
      style: ElevatedButton.styleFrom(
        primary: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      label: Text(
        text,
        style: Get.textTheme.headline6,
      ),
      icon: Icon(
        text.contains('hand') ||
                text.contains('received') ||
                text.contains('Liye')
            ? Icons.download_for_offline_rounded
            : LineIcons.arrowUp,
        color: Colors.white,
      ),
    );
  }
}
