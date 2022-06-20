// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/gen/assets.gen.dart';

// Project imports:
import '../../animations/page_transition.dart';
import '../main_views/auth/login_screen.dart';

class OnBoardScreen extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();

  OnBoardScreen({Key? key}) : super(key: key);

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      PageTransition(
        const LoginScreen(),
      ),
    );
  }

  Widget buildWelcomeImage1() {
    return Image.asset(
      Assets.images.onboard1st.livesMatter.path,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }

  Widget buildWelcomeImage2() {
    return Image.asset(
      Assets.images.onboard2nd.partying.path,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    // //?setting portrait only orientation
    // // ignore: unnecessary_statements
    // kPortraitOnly;

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: kPrimaryColor,
      showDoneButton: false,
      isBottomSafeArea: true,
      isTopSafeArea: true,
      globalFooter: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: SizedBox(
          width: kWidth * 0.8,
          height: kToolbarHeight,
          child: ElevatedButton(
            child: Text(
              kOnBoardBtnText,
              style: Get.textTheme.headline5?.copyWith(color: Colors.black),
            ),
            onPressed: () => _onIntroEnd(context),
          ),
        ),
      ),

      pages: [
        PageViewModel(
          titleWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'WAS IST',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Image.asset(
                Assets.images.onboard1st.onboardImage1.path,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              )
            ],
          ),
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                Assets.images.onboard1st.livesMatter.path,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: const TextSpan(text: kOnbardOneTxt),
              )
            ],
          ),
          decoration: pageDecoration,
          useScrollView: true,
        ),
        PageViewModel(
          titleWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'WAS IST',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Image.asset(
                Assets.images.onboard1st.onboardImage1.path,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              )
            ],
          ),
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                Assets.images.onboard2nd.partying.path,
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
              const SizedBox(
                height: 30,
              ),
              RichText(
                text: const TextSpan(text: kOnbardTwoTxt),
              )
            ],
          ),
          decoration: pageDecoration,
          useScrollView: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,

      nextFlex: 0,
      showNextButton: false,
      //rtl: true, // Display as right-to-left
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Start', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        // color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
