// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Package imports:

// Project imports:
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/view/main_views/shopping/widgets/cart_item_widget.dart';
import 'package:pay_qr/widgets/shared/custom_btn.dart';
import 'package:pay_qr/widgets/shared/custom_text.dart';

import '../payments/payment_screen.dart';

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: CustomText(
                text: "Shopping Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() => Column(
                  children: userController.userModel.value.cart
                          ?.map((cartItem) => CartItemWidget(
                                cartItem: cartItem,
                              ))
                          .toList() ??
                      [],
                )),
          ],
        ),
        Positioned(
            bottom: 30,
            child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8),
                child: CustomButton(
                    text:
                        "Pay Rs ${cartController.totalCartPrice.value.toString()}",
                    onTap: () {
                      // paymentController.makePayment(
                      //     amount: cartController.totalCartPrice.value
                      //         .toStringAsFixed(0),
                      //     currency: 'USD');
                      if (cartController.totalCartPrice.value > 0) {
                        Get.to(() => const PaymentScreen());
                      } else {
                        showToast(msg: 'Cart is Empty');
                        return;
                      }
                    })))
      ],
    );
  }
}
