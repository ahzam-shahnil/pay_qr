import 'package:flutter/material.dart';
import 'package:pay_qr/gen/assets.gen.dart';

class AnimatedLogo extends StatefulWidget {
  final Duration? animationDuration;
  final double? size;
  final String? imageString;
  final Widget? child;

  const AnimatedLogo({
    Key? key,
    this.animationDuration = const Duration(milliseconds: 1000),
    this.size = 100.0,
     this.imageString,
    this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: widget.animationDuration, vsync: this);
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween(begin: 0.75, end: 2.0).animate(
          CurvedAnimation(parent: _controller, curve: Curves.elasticOut)),
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: widget.child ??
            CircleAvatar(backgroundImage: AssetImage(widget.imageString?? Assets.images.nameLogo.path)),
      ),
    );
  }
}
