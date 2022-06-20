// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/view/main_views/digi_khata/digi_nav.dart';
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
          padding: const EdgeInsets.all(15),
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
                          height: kHeight * 0.3,
                          onTap: () {
                            // Get.to(() => const ProductAddScreen());
                          },
                          text: 'Current balance',
                          width: kWidth * 0.43,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomCard(
                          color: Colors.blue,
                          onTap: () {
                            Get.to(() => const DigiNavHome());
                          },
                          width: kWidth * 0.43,
                          height: kHeight * 0.14,
                          text: 'DIGI Khata',
                        ),
                        Obx(() => loginController.isMerchant()
                            ? CustomCard(
                                color: kPrimaryColor,
                                onTap: () {
                                  Get.to(() => const ProductAddScreen());
                                },
                                width: kWidth * 0.43,
                                height: kHeight * 0.14,
                                text: 'Add Product',
                              )
                            : const SizedBox()),
                        SizedBox(
                          height: kHeight * 0.01,
                        ),
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
