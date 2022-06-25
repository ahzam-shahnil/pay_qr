// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/view/main_views/digi_khata/digi_nav.dart';
import 'package:pay_qr/view/main_views/payments/payment_screen.dart';
import 'package:pay_qr/view/main_views/product_add/product_add_screen.dart';
import 'package:pay_qr/widgets/shared/custom_card.dart';

// Project imports:

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              SizedBox(
                width: kWidth,
                height: kHeight * 0.4,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CustomCard(
                          color: kTealColor,
                          height: kHeight * 0.35,
                          onTap: () {
                            Get.to(() => const PaymentScreen());
                          },
                          text: 'Current balance',
                          width: kWidth * 0.55,
                          colors: const [Color(0xFF20bf55), kTealColor],
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () =>
                              userController.userModel.value.isMerchant ?? false
                                  ? CustomCard(
                                      color: Colors.blue,
                                      onTap: () {
                                        Get.to(() => const DigiNavHome());
                                      },
                                      width: kWidth * 0.3,
                                      height: kHeight * 0.17,
                                      text: 'DIGI Khata',
                                      colors: const [
                                        Color(0xFF00d2ff),
                                        Color(0xff3a7bd5)
                                      ],
                                    )
                                  : CustomCard(
                                      color: Colors.blue,
                                      onTap: () {
                                        Get.to(() => const DigiNavHome());
                                      },
                                      width: kWidth * 0.55,
                                      height: kHeight * 0.35,
                                      text: 'DIGI Khata',
                                      colors: const [
                                        Color(0xFF00d2ff),
                                        Color(0xff3a7bd5)
                                      ],
                                    ),
                        ),
                        Obx(
                          () =>
                              userController.userModel.value.isMerchant ?? false
                                  ? CustomCard(
                                      color: kPrimaryColor,
                                      onTap: () {
                                        Get.to(() => const ProductAddScreen());
                                      },
                                      width: kWidth * 0.3,
                                      height: kHeight * 0.17,
                                      text: 'Add Product',
                                      colors: const [
                                        Color(0xFFFF5F6D),
                                        Color(0xffFFC371)
                                      ],
                                    )
                                  : const SizedBox(),
                        )
                        // SizedBox(
                        //   height: kHeight * 0.01,
                        // ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
