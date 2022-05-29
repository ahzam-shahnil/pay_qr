import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ReuseableCard extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backColor;
  final String description;
  final bool isMaineLene;

  const ReuseableCard(
      {Key? key,
      required this.text,
      required this.textColor,
      required this.backColor,
      required this.description,
      required this.isMaineLene})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: backColor,
      leading: CircleAvatar(
        backgroundColor: textColor,
        radius: Get.size.shortestSide * 0.048,
        child: Icon(
          isMaineLene ? Icons.download_for_offline_rounded : LineIcons.arrowUp,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        text,
        style: Get.textTheme.bodyMedium?.copyWith(color: textColor),
      ),
      title: Text(
        'Rs $description',
        style: Get.textTheme.headline6?.copyWith(
            color: textColor, fontSize: Get.size.shortestSide * 0.045),
      ),
    );
  }
}
