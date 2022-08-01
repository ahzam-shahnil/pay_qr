import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/model/payment_model.dart';
import 'package:pay_qr/utils/utility.dart';

import '../../../../config/controllers.dart';

class PaymentHistoryInfoScreen extends StatelessWidget {
  const PaymentHistoryInfoScreen({Key? key, required this.paymentsModel})
      : super(key: key);
  final PaymentModel paymentsModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   centerTitle: true,
      //   title:,
      // ),
      body: SafeArea(
        child: ListView(
          children: [
            Card(
              margin: EdgeInsets.zero,
              shape: const RoundedRectangleBorder(
                // side: BorderSide.
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              color:
                  paymentsModel.senderId == userController.userModel.value.uid
                      ? kPrimaryColor
                      : kTealColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(Icons.arrow_back_ios_new_rounded)),
                      SizedBox(
                        width: kWidth * 0.19,
                      ),
                      Text(
                        paymentsModel.senderId ==
                                userController.userModel.value.uid
                            ? 'Money Received'
                            : 'Money Sent',
                        textAlign: TextAlign.start,
                        style: Get.textTheme.headline6,
                      )
                    ],
                  ),
                  SizedBox(
                    height: kWidth * 0.08,
                  ),
                  CircleAvatar(
                    radius: kHeight * 0.07,
                    backgroundColor: kScanBackColor,
                    child: Icon(
                      paymentsModel.receiverId ==
                              userController.userModel.value.uid
                          ? LineIcons.arrowDown
                          : LineIcons.arrowUp,
                      color: paymentsModel.senderId ==
                              userController.userModel.value.uid
                          ? kPrimaryColor
                          : kTealColor,
                      size: kHeight * 0.07,
                    ),
                  ),
                  SizedBox(
                    height: kWidth * 0.04,
                  ),
                  Text(
                    '${paymentsModel.senderId == userController.userModel.value.uid ? '-' : '+'} ${paymentsModel.amount}',
                    style: Get.textTheme.headline5
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: kWidth * 0.04,
                  ),
                  Text(
                    "From ${paymentsModel.sender}",
                    style: Get.textTheme.headline6,
                  ),
                  Text(
                    "To ${paymentsModel.receiver}",
                    style: Get.textTheme.headline6,
                  ),
                  Text(
                    Utility.getFormatedDate(DateTime.parse(paymentsModel.date)),
                    style: Get.textTheme.bodyMedium
                        ?.copyWith(color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'From',
                      style: Get.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      paymentsModel.sender,
                      style: Get.textTheme.bodyMedium
                          ?.copyWith(color: Colors.black),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      'To',
                      style: Get.textTheme.bodyLarge
                          ?.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      paymentsModel.receiver,
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const Divider(
                      height: 6,
                      thickness: 1,
                    ),
                    Text(
                      "Reference Number\n${paymentsModel.paymentId}",
                      style: Get.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
