import 'package:flutter/material.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum _ColorTween { color1, color2 }

class AnimatedBackground extends StatelessWidget {
  const AnimatedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTween<_ColorTween>()
      ..add(
        _ColorTween.color1,
        kTealColor.withOpacity(0.8).tweenTo(Colors.lightBlue.shade900),
        const Duration(seconds: 3),
      )
      ..add(
        _ColorTween.color2,
        kLightBackColor.tweenTo(kTealColor.withOpacity(0.8)),
        const Duration(seconds: 3),
      );
    return MirrorAnimation<MultiTweenValues<_ColorTween>>(
      tween: tween,
      duration: tween.duration,
      builder: (context, child, value) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                value.get<Color>(_ColorTween.color1),
                value.get<Color>(_ColorTween.color2)
              ],
            ),
          ),
        );
      },
    );
  }
}
