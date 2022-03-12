// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/view/main_views/product_add/product_add_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text("User type is ${userType == '0' ? "merchant" : "1"}"),

          Obx(
            () => loginController.isMerchant()
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () => Get.to(() => const ProductAddScreen()),
                    child: const Text("Add Product"),
                  )
                : const SizedBox(),
          )
        ],
      ),
    );
  }
}
