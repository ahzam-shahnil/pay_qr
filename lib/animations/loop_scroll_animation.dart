// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:marquee/marquee.dart';

class LoopScrollAnimation extends StatelessWidget {
  const LoopScrollAnimation({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Marquee(
        text: text,
        style: const TextStyle(fontWeight: FontWeight.bold),
        blankSpace: 20.0,
      ),
    );
  }
}
