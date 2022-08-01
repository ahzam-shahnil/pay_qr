// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Text(
        //   login ? "Ich habe noch kein Konto? " : "Ich habe ein Bankkonto ",
        //   style: Get.textTheme.headline6,
        // ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Don’t have an Account ? " : "Already have an Account ? ",
            style: Get.textTheme.bodyMedium?.copyWith(color: Colors.white),
          ),
        )
      ],
    );
  }
}
