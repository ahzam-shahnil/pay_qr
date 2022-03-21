// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/view/main_views/digi_khata/digi_nav.dart';
import 'package:pay_qr/view/main_views/product_add/product_add_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: GridView.count(
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      // primary: kScanBackColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Get.to(() => const DigiNavHome());
                  },
                  child: const Text('DIGI Khata')),
              Obx(
                () => loginController.isMerchant()
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            // primary: kScanBackColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () => Get.to(() => const ProductAddScreen()),
                        child: const Text("Add Product"),
                      )
                    : const SizedBox(),
              )
            ]),
      ),
    );

    // return Center(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: const [
    //       // Text("Us
    //       //er type is ${userType == '0' ? "merchant" : "1"}"),
    //     ],
    //   ),
    // );
  }
}
