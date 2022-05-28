// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:simple_animations/stateless_animation/mirror_animation.dart';

class MirrorFadedAnimation extends StatelessWidget {
  final String text;
  const MirrorFadedAnimation({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MirrorAnimation<double>(
      tween: Tween(begin: -100.0, end: 100.0), // value for offset x-coordinate
      duration: const Duration(seconds: 2),
      curve: Curves.easeInOutSine, // non-linear animation
      builder: (context, child, value) {
        return Transform.translate(
          offset: Offset(value, 0), // use animated value for x-coordinate
          child: child,
        );
      },
      child: Text(
        text,
        softWrap: false,
        maxLines: 1,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.headline3?.copyWith(
            fontWeight: FontWeight.bold, color: Colors.white.withOpacity(0.06)),
      ),
    );
  }
}
