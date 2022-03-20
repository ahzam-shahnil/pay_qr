import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/digi_khata/customer.dart';
import 'package:pay_qr/view/main_views/digi_khata/customer_record_view.dart';
import 'package:pay_qr/widgets/digi_khata/reusable_card.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../model/digi_khata/cash_in_model.dart';
import 'add_customer/contact_view.dart';

class DigiKhataView extends StatefulWidget {
  const DigiKhataView({Key? key}) : super(key: key);

  @override
  _DigiKhataViewState createState() => _DigiKhataViewState();
}

class _DigiKhataViewState extends State<DigiKhataView> {
  Color? inactiveRed = Colors.red[100];
  Color? activeRed = Colors.red;
  Color? inactiveGreen = Colors.green[100];
  Color? activeGreen = Colors.green;

  _getPermission() async {
    if (await Permission.contacts.request().isGranted) {
      Get.to(
        () => const ContactView(),
      );
    }
  }

  Widget getRecordText(List<CashModel> records) {
    double total = 0;
    double diye = 0;
    double liye = 0;
    for (var item in records) {
      diye += item.diye;
      liye += item.liye;
    }
    total = total + diye + (-liye);

    return Text(
      total.toStringAsFixed(0).replaceAll('-', ''),
      style: Get.textTheme.headline6
          ?.copyWith(color: diye > liye ? Colors.green : Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 16.0,
            ),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Row(
                children: const [
                  Expanded(
                    child: ReuseableCard(
                      textcolour: Colors.white,
                      buttonColour: Colors.red,
                      text: "To be given",
                      description: '',
                    ),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Expanded(
                    child: ReuseableCard(
                      buttonColour: Colors.green,
                      textcolour: Colors.white,
                      text: "To be received",
                      description: '',
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder(
              stream: digiController.getRecordStream(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  var data = snapshot.data!.docs
                      .map((e) => CustomerModel.fromSnapshot(e))
                      .toList();

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      const Divider(),
                      SizedBox(
                        height: Get.size.height * 0.7,
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: data.length,
                          primary: true,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            child: ListTile(
                              onTap: () => Get.to(() => CustomerRecordsView(
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
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  getRecordText(data[index].cashRecords)
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(),
                        ),
                      ),
                    ],
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            _getPermission();
          },
          label: const Text('Add customer'),
          icon: const Icon(Icons.add),
          backgroundColor: kPrimaryColor.withOpacity(0.5)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
