import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AmountText extends StatelessWidget {
  const AmountText({Key? key, required this.totalAmount}) : super(key: key);
  final String totalAmount;
  @override
  Widget build(BuildContext context) {
    return Text(
      totalAmount.replaceAll('-', ''),
      style: Get.textTheme.headline6?.copyWith(
          color: totalAmount.contains('-') ? Colors.green : Colors.red),
    );
  }
}
