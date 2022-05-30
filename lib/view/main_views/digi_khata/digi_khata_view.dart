import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/gen/assets.gen.dart';
import 'package:pay_qr/model/digi_khata/customer.dart';
import 'package:pay_qr/utils/utility_helper.dart';
import 'package:pay_qr/widgets/digi_khata/amount_text.dart';
import 'package:pay_qr/widgets/digi_khata/reusable_card.dart';

import 'add_customer/customer_record_view.dart';

class DigiKhataView extends StatefulWidget {
  const DigiKhataView({Key? key}) : super(key: key);

  @override
  State<DigiKhataView> createState() => _DigiKhataViewState();
}

class _DigiKhataViewState extends State<DigiKhataView> {
  // Color? inactiveRed = Colors.red[100];
  // Color? activeRed = Colors.red;
  // Color? inactiveGreen = Colors.green[100];
  // Color? activeGreen = Colors.green;
  // @override
  // void didChangeDependencies() {
  //   amountController.resetData();
  //   super.didChangeDependencies();
  // }
  @override
  void reassemble() {
    super.reassemble();
    amountController.resetData();
    logger.d('ON resAssemble');
  }

  @override
  void dispose() {
    amountController.resetData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        children: [
          const SizedBox(
            height: 16.0,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              children: [
                Obx(() => Expanded(
                      child: ReuseableCard(
                        textColor: Colors.red,
                        backColor: kScanBackColor,
                        text: "Maine Lene hain",
                        description: (amountController.totalPaisayLene.value -
                                    amountController.totalPaisayDene.value) <
                                0
                            ? (amountController.totalPaisayLene.value -
                                    amountController.totalPaisayDene.value)
                                .toStringAsFixed(0)
                                .replaceAll('-', '')
                            : '0',
                        isMaineLene: true,
                      ),
                    )),
                const SizedBox(
                  width: 8.0,
                ),
                Obx(() => Expanded(
                      child: ReuseableCard(
                        backColor: kScanBackColor,
                        textColor: Colors.green,
                        text: "Maine Dene hain",
                        description: (amountController.totalPaisayLene.value -
                                    amountController.totalPaisayDene.value) >
                                0
                            ? (amountController.totalPaisayLene.value +
                                    amountController.totalPaisayDene.value)
                                .toStringAsFixed(0)
                                .replaceAll('-', '')
                            : '0',
                        isMaineLene: false,
                      ),
                    )),
              ],
            ),
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

                return Card(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SizedBox(
                        height: Get.size.height * 0.65,
                        child: data.isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                itemCount: data.length,
                                primary: true,
                                itemBuilder: (context, index) {
                                  double amount = Utility.calculateAmount(
                                      data[index].cashRecords);

                                  //? to fix marks needs build we use Future delayed
                                  Future.delayed(Duration.zero, () {
                                    if (amount < 0) {
                                      amountController.totalPaisayDene.value +=
                                          amount;
                                    } else {
                                      amountController.totalPaisayLene.value +=
                                          amount;
                                    }
                                  });
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
                                height: Get.size.height * 0.65,
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
                                        height: Get.size.height * 0.2,
                                      ),
                                      Text(
                                        'Tap Here to Add customer',
                                        style: Get.textTheme.headline5
                                            ?.copyWith(
                                                color: kPrimaryColor,
                                                fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
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
