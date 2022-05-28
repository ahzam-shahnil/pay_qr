// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'text_scroll_animation.dart';

class TextAnimatedBackground extends StatelessWidget {
  const TextAnimatedBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: Get.size.height * 0.01,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // text: 'GEGEN RASSISMUS \tGEGEN RASSISMUS',

                const TextScrollAnimation(
                    text: 'GEGEN RASSISMUS\t\tGEGEN RASSISMUS'),
                const TextScrollAnimation(
                    text: 'GEGEN RASSISMUS\t\tGEGEN RASSISMUS'),
                const TextScrollAnimation(
                    text: 'GEGEN SEXIMUS\t\tGEGEN SEXIMUS'),
                SizedBox(
                  height: Get.size.height * 0.01,
                ),
              ],
            ),
          ),
          SizedBox(
            height: Get.size.height * 0.1,
          ),
          Flexible(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  TextScrollAnimation(
                      text: 'GEGEN ABLEISMUS\t\tGEGEN ANTISEMITISMUS'),
                  TextScrollAnimation(
                      text:
                          'GEGEN QUERFEINDLICHKEIT\t\tGEGEN QUERFEINDLICHKEIT'),
                  TextScrollAnimation(text: 'GEGEN TRANSFEINDLICHKEIT'),
                  TextScrollAnimation(text: 'GEGEN SEXIMUS\t\tGEGEN SEXIMUS'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
