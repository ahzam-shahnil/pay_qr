import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/widgets/loading_button.dart';

import '../../../config/controllers.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String cardNumber = "5450 7879 4864 7854";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      appBar: AppBar(
        title: const Text('Payment Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // CreditCard(
            //     cardNumber: cardNumber,
            //     cardExpiry: "10/25",
            //     cardHolderName: "Card Holder",
            //     cvv: "456",
            //     bankName: "Axis Bank",
            //     // cardType: CardType
            //     //     .masterCard, // Optional if you want to override Card Type
            //     showBackSide: false,
            //     frontBackground: CardBackgrounds.black,
            //     backBackground: CardBackgrounds.white,
            //     showShadow: true,
            //     textExpDate: 'Exp. Date',
            //     textName: 'Name',
            //     textExpiry: 'MM/YY'),
            const SizedBox(
              height: 25,
            ),
            // CardField(
            //   dangerouslyUpdateFullCardDetails: true,
            //   onCardChanged: (card) {
            //     logger.i(card);
            //     // setState(() {
            //     //   cardNumber = card?.number ?? '5450 7879 4864 7854';
            //     // });
            //   },
            // ),
            const SizedBox(
              height: 25,
            ),
            Obx(() => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kWidth * 0.3),
                  child: LoadingButton(
                      onPressed: () async {
                        //TODO: Add payment controller
                        // await paymentsController.createPaymentMethod();
                        // Get.back();
                      },
                      text:
                          'Pay (Rs ${cartController.totalCartPrice.value.toStringAsFixed(2)})'),
                ))
          ],
        ),
      ),
    );
  }
}
