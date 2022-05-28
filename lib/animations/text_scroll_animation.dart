// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:text_scroll/text_scroll.dart';

class TextScrollAnimation extends StatelessWidget {
  final String text;
  const TextScrollAnimation({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextScroll(
      text,
      mode: TextScrollMode.endless,
      velocity: const Velocity(pixelsPerSecond: Offset(80, 0)),
      style: Theme.of(context).textTheme.headline3?.copyWith(
          fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.06)),
      textAlign: TextAlign.right,
      selectable: false,
    );
  }
}
