import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCard extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final double width;
  final double height;
  final String text;
  const CustomCard({
    Key? key,
    required this.color,
    required this.onTap,
    required this.width,
    required this.height,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Text(
              text,
              style: Get.textTheme.headline6,
            ),
          ),
        ),
      ),
    );
  }
}
