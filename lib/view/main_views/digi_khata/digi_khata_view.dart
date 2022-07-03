import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/gen/assets.gen.dart';
import 'package:pay_qr/model/customer.dart';
import 'package:pay_qr/utils/utility.dart';
import 'package:pay_qr/widgets/digi_khata/amount_text.dart';
import 'package:pay_qr/widgets/digi_khata/reusable_card.dart';

import 'add_customer/customer_record_view.dart';

class DigiKhataView extends StatelessWidget {
  const DigiKhataView({Key? key}) : super(key: key);

  final double total = 0;
  // @override
  // void reassemble() {
  //   super.reassemble();
  //   Future.delayed(Duration.zero, () {
  //     amountController.resetData();
  //   });
  //   logger.d('ON resAssemble');
  // }

  // @override
  // void dispose() {
  //   Future.delayed(Duration.zero, () {
  //     amountController.resetData();
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          StreamBuilder(
            stream: digiController.getRecordStream(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: kScanBackColor,
                  ),
                );
              }

              if (snapshot.hasData) {
                var data = snapshot.data!.docs
                    .map((e) => CustomerModel.fromSnapshot(e))
                    .toList();
                String total = Utility.calculateDigiTotal(customers: data);
                // data.isEmpty ? amountController.resetData() : null;
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ReuseableCard(
                              textColor: Colors.red,
                              backColor: kScanBackColor,
                              text: "Maine Lene hain",
                              // title:(total=Utility.calculateTotal(records, total)).toString(),
                              title: total.contains('-')
                                  ? '0'
                                  : total.replaceAll('-', ''),
                              isMaineLene: true,
                            ),
                          ),
                          const SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: ReuseableCard(
                              backColor: kScanBackColor,
                              textColor: Colors.green,
                              text: "Maine Dene hain",
                              title: total.contains('-')
                                  ? total.replaceAll('-', '')
                                  : '0',
                              isMaineLene: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      child: SizedBox(
                        height: kHeight * 0.65,
                        child: data.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                itemCount: data.length,
                                primary: true,
                                itemBuilder: (context, index) {
                                  double amount = Utility.calculateAmount(
                                      data[index].cashRecords);

                                  return ListTile(
                                    onTap: () =>
                                        Get.to(() => CustomerRecordsView(
                                              customer: data[index],
                                            )),
                                    isThreeLine: false,
                                    title: Text(data[index].name),
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blueGrey.shade200,
                                      child: const Icon(
                                        Icons.person_outline,
                                        color: Colors.white,
                                      ),
                                    ),
                                    trailing: AmountText(
                                        totalAmount: amount.toStringAsFixed(0)),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                              )
                            : SizedBox(
                                height: kHeight * 0.65,
                                width: double.infinity,
                                child: GestureDetector(
                                  onTap: () {
                                    digiController
                                        .getPermissionAndGotoContactView();
                                  },
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image(
                                        image: Assets.images.addUser,
                                        height: kHeight * 0.2,
                                      ),
                                      Text(
                                        'Tap Here to Add customer',
                                        style: Get.textTheme.headline5
                                            ?.copyWith(
                                                color: kTealColor,
                                                fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              }
              return const Center(
                  child: CircularProgressIndicator(
                color: kScanBackColor,
              ));
            },
          )
        ],
      ),
    );
  }
}
