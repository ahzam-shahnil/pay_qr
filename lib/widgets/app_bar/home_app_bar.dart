// Flutter imports:
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "PayQr",
        style: TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
