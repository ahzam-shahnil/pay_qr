// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import '../main_views/shopping/scan_screen.dart';

class ScanIntroScreen extends StatelessWidget {
  const ScanIntroScreen({Key? key}) : super(key: key);
  // final controller = Get.lazyPut(() => ProductController(), fenix: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: kScanBackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/images/scan_intro.png',
                  height: Get.size.height * 0.4),
              // const SizedBox(height: 20),
              Text(
                'Scan, Pay & Enjoy!',
                textAlign: TextAlign.center,
                style: Get.textTheme.headline4?.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                kScanDescText,
                textAlign: TextAlign.center,
                softWrap: true,
                maxLines: 5,
                style: Get.textTheme.headline6?.copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: kWidth * 0.24, vertical: 8),
                child: ElevatedButton.icon(
                  onPressed: () => Get.to(() => const ScanScreen()),
                  label: Text(
                    'Go Shopping!',
                    style: Get.textTheme.headline6?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  icon: const Icon(LineIcons.arrowRight),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
