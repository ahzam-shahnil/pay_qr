import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ReuseableCard extends StatelessWidget {
  final String text;
  final Color textcolour;
  final Color buttonColour;
  final String description;

  const ReuseableCard(
      {Key? key,
      required this.text,
      required this.textcolour,
      required this.buttonColour,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: buttonColour.withOpacity(0.7),
      leading: CircleAvatar(
        backgroundColor: buttonColour,
        child: Icon(
          text.contains('hand') ||
                  text.contains('received') ||
                  text.contains('Lainy') ||
                  description.contains('Kamae')
              ? Icons.download_for_offline_rounded
              : LineIcons.arrowUp,
          color: Colors.white,
        ),
      ),
      title: Text(
        text,
        style: Get.textTheme.headline6,
      ),
      subtitle: Text(
        description,
        style: Get.textTheme.headline6,
      ),
    );
  }
}
