// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/payment_model.dart';
import 'package:pay_qr/utils/utility.dart';
import 'package:pay_qr/view/main_views/digi_khata/digi_nav.dart';
import 'package:pay_qr/view/main_views/payments/payment_screen.dart';
import 'package:pay_qr/view/main_views/payments/widgets/payment_widget.dart';
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
      // left: false,
      // right: false,
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            children: [
              SizedBox(
                width: kWidth,
                height: kHeight * 0.4,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Obx(
                          () => CustomCard(
                            color: kTealColor,
                            height: kHeight * 0.35,
                            onTap: () {
                              Get.to(() => const PaymentHomeScreen());
                            },
                            text:
                                'Current balance\n\t\t\t\t${userController.userModel.value.balance}',
                            width: userController.userModel.value.isMerchant ==
                                    true
                                ? kWidth * 0.55
                                : kWidth * 0.5,
                            colors: const [Color(0xFF20bf55), kTealColor],
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                          () =>
                              userController.userModel.value.isMerchant == true
                                  ? CustomCard(
                                      color: kPrimaryColor,
                                      onTap: () {
                                        Get.to(() => const DigiNavHome());
                                      },
                                      width: kWidth * 0.35,
                                      height: kHeight * 0.17,
                                      text: 'DIGI Khata',
                                      colors: const [
                                        Color(0xFFFF5F6D),
                                        Color(0xffFFC371)
                                      ],
                                    )
                                  : CustomCard(
                                      color: kPrimaryColor,
                                      onTap: () {
                                        Get.to(() => const DigiNavHome());
                                      },
                                      width: kWidth * 0.42,
                                      height: kHeight * 0.35,
                                      text: 'DIGI Khata',
                                      colors: const [
                                        Color(0xFFFF5F6D),
                                        Color(0xffFFC371)
                                      ],
                                    ),
                        ),
                        Obx(
                          () =>
                              userController.userModel.value.isMerchant == true
                                  ? CustomCard(
                                      color: Colors.blue,
                                      onTap: () {
                                        Get.to(() => const ProductAddScreen());
                                      },
                                      width: kWidth * 0.35,
                                      height: kHeight * 0.17,
                                      text: 'Add Product',
                                      colors: const [
                                        Color(0xFF00d2ff),
                                        Color(0xff3a7bd5)
                                      ],
                                    )
                                  : const SizedBox(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: paymentsController.getPaymentHistoryStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text('Something went wrong'));
                  }

                  if (snapshot.hasData) {
                    var data = snapshot.data!.docs
                        .map((e) => PaymentModel.fromSnapshot(e))
                        .toList();
                    // logger.d(data);
                    // data.isEmpty ? amountController.resetData() : null;
                    return data.isNotEmpty
                        ? Card(
                            child: SizedBox(
                              height: kHeight * 0.43,
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          Utility.getDateFormatted(
                                              DateTime.parse(data[index].date)),
                                          textAlign: TextAlign.start,
                                          style: index == 0
                                              ? Get.textTheme.headline6
                                                  ?.copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w500)
                                              : Get.textTheme.bodyLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400),
                                        ),
                                        PaymentWidget(
                                            paymentsModel: data[index]),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              ),
                            ),
                          )
                        : const SizedBox();
                  }
                  return const SizedBox();
                },
              )
            ],
          )),
    );
  }
}
