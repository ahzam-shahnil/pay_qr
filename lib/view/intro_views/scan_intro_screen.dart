// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/gen/assets.gen.dart';

import '../main_views/payments/scan_screen.dart';

class ScanIntroScreen extends StatelessWidget {
  const ScanIntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Card(
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            // mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: kScanBackColor.withOpacity(0.9),
                shape: const CircleBorder(),
                clipBehavior: Clip.hardEdge,
                elevation: 5,
                child: SizedBox(
                  width: kWidth * 0.6,
                  height: kHeight * 0.35,
                  child: Image.asset(
                    Assets.images.scanIntro.path,
                    fit: BoxFit.contain,
                    height: Get.size.height * 0.27,
                    scale: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Column(
                children: [
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
                      horizontal: kWidth * 0.18,
                      vertical: 8,
                    ),
                    child: ElevatedButton(
                      onPressed: () => Get.to(() => const ScanScreen(
                            isFromShopScreen: true,
                          )),
                      child: Text(
                        'Go Shopping!',
                        style: Get.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: kScanBackColor
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
