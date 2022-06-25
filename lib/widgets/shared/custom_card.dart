import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/gen/assets.gen.dart';

class CustomCard extends StatelessWidget {
  final Color color;
  final VoidCallback onTap;
  final double width;
  final double height;
  final List<Color> colors;
  final String text;
  const CustomCard({
    Key? key,
    required this.color,
    required this.onTap,
    required this.width,
    required this.height,
    required this.text,
    required this.colors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: color,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              // foregroundDecoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: Assets.images.arrow,
              //     alignment: Alignment.bottomRight,
              //     // fit: BoxFit.contain,
              //     scale: 0.2,
              //   ),
              // ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: Center(
                child: Text(
                  text,
                  style: Get.textTheme.headline6,
                ),
              ),
            ),
            Positioned(
              right: 6,
              bottom: 5,
              child: Image.asset(
                Assets.images.arrow.path,
                width: kWidth * 0.15,
              ),
            )
          ],
        ),
      ),
    );
  }
}
