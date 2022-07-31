// Flutter imports:
import 'package:flutter/material.dart';
import 'package:pay_qr/config/app_constants.dart';

// Project imports:

class TextFieldContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final Color? backColor;
  const TextFieldContainer({
    Key? key,
    this.child,
    this.height,
    this.backColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      height: height,
      decoration: BoxDecoration(
        color: backColor?.withOpacity(0.8) ?? kTextFieldColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
