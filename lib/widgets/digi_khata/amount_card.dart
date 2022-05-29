import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

import '../../config/app_constants.dart';

class AmountCard extends StatelessWidget {
  const AmountCard({Key? key, required this.totalAmount}) : super(key: key);
  final String totalAmount;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: kScanBackColor,
      leading: CircleAvatar(
        backgroundColor: totalAmount.contains('-') ? Colors.green : Colors.red,
        child: Icon(
          totalAmount.contains('-')
              ? LineIcons.arrowUp
              : Icons.download_for_offline_rounded,
          color: kScanBackColor,
        ),
      ),
      subtitle: Text(
        totalAmount.contains('-') ? 'Maine dene hain' : "Maine lene hain",
        style: Get.textTheme.headline6?.copyWith(
            color: totalAmount.contains('-') ? Colors.green : Colors.red),
      ),
      title: Text(
        totalAmount.replaceAll('-', ''),
        style: Get.textTheme.headline6?.copyWith(
            color: totalAmount.contains('-') ? Colors.green : Colors.red),
      ),
    );
  }
}
