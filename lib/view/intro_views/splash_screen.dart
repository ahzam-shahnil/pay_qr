// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/gen/assets.gen.dart';

import '../../animations/text_animated_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation1;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    animation1 = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    _controller.forward();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    // Timer(const Duration(seconds: 4), () {
    //   setState(() {
    //     Navigator.pushReplacement(
    //       context,
    //       PageTransition(
    //         OnBoardScreen(),
    //       ),
    //     );
    //   });
    // });
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kPrimaryColor.withOpacity(0.8),
      body: Stack(
        children: [
          const TextAnimatedBackground(),
          Column(
            children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: height / _fontSize),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 1000),
                opacity: _textOpacity,
                child: Text(
                  kAppName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: animation1.value,
                    
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: height * 0.19,
            right: 0,
            left: 0,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 2000),
              curve: Curves.fastLinearToSlowEaseIn,
              opacity: _containerOpacity,
              child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  height: height / _containerSize,
                  width: width * 0.9,
                  alignment: Alignment.center,
                  child: Image.asset(
                    Assets.images.nameLogo.path,
                    colorBlendMode: BlendMode.clear,
                    fit: BoxFit.cover,
                  )),
            ),
            //
          ),
        ],
      ),
    );
  }
}
// class SpalshScreen extends StatefulWidget {
//   const SpalshScreen({Key? key}) : super(key: key);

//   @override
//   _SpalshScreenState createState() => _SpalshScreenState();
// }

// class _SpalshScreenState extends State<SpalshScreen>
//     with TickerProviderStateMixin {
 
// }
