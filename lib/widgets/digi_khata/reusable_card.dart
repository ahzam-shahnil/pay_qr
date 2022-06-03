import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ReuseableCard extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backColor;
  final String title;
  final bool isMaineLene;
  final bool? useIcon;

  const ReuseableCard(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.backColor,
      required this.title,
      required this.isMaineLene,
      this.useIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: backColor,
      leading: useIcon == null
          ? CircleAvatar(
              backgroundColor: textColor,
              radius: Get.size.shortestSide * 0.048,
              child: Icon(
                isMaineLene
                    ? Icons.download_for_offline_rounded
                    : LineIcons.arrowUp,
                color: Colors.white,
              ),
            )
          : null,
      subtitle: Text(
        text,
        textAlign: useIcon != null ? TextAlign.center : TextAlign.start,
        style: Get.textTheme.bodyMedium?.copyWith(
            color: textColor,
            fontWeight: useIcon != null ? FontWeight.bold : null),
      ),
      title: Text(
        'Rs $title',
        textAlign: useIcon != null ? TextAlign.center : TextAlign.start,
        style: Get.textTheme.headline6?.copyWith(
            color: textColor,
            fontSize: Get.size.shortestSide * 0.045,
            fontWeight: useIcon != null ? FontWeight.bold : null),
      ),
    );
  }
}
