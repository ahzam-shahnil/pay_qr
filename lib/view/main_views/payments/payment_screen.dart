import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';

import '../../../config/controllers.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          CardField(
            onCardChanged: (card) {
              logger.i(card);
            },
          ),
          Obx(() => TextButton(
                onPressed: () async {
                  // create payment method
                  // final paymentMethod = await Stripe.instance
                  //     .createPaymentMethod(const PaymentMethodParams.card());
                  //TODO: Add Payment here
                  paymentsController.createPaymentMethod();
                },
                child: Text(
                    'Pay (Rs ${cartController.totalCartPrice.value.toStringAsFixed(2)})'),
              ))
        ],
      ),
    );
  }
}
