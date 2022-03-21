import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/digi_khata/cash_in_model.dart';
import 'package:pay_qr/widgets/digi_khata/reusable_card.dart';
import 'package:pay_qr/widgets/digi_khata/reuseable_button.dart';

import 'cash_in_out.dart';

class CashBook extends StatefulWidget {
  const CashBook({Key? key}) : super(key: key);

  @override
  _CashBookState createState() => _CashBookState();
}

class _CashBookState extends State<CashBook> {
  // String addMoney(snapshot, String name) {
  //   double cash = 0;
  //   for (var item in snapshot.data!.docs) {
  //     cash += double.parse(item[name]);
  //   }

  //   return cash.toString();
  // }
  String calculateCashOut(List<CashModel> records) {
    double total = 0;
    double diye = 0;

    for (var item in records) {
      diye += item.diye;
    }
    return (total = total + diye).toString();
  }

  String calculateCashIn(List<CashModel> records) {
    double total = 0;
    double liye = 0;

    for (var item in records) {
      liye += item.liye;
    }
    return (total = total + liye).toString();
  }

  DateTime date = DateTime.now();
  late var formattedDate = DateFormat('d-MMM-yy').format(date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      resizeToAvoidBottomInset: true,
      body: StreamBuilder(
        stream: digiController.getCashBookStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasData) {
            var data = snapshot.data!.docs
                .map((e) => CashModel.fromSnapshot(e))
                .toList();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ReuseableCard(
                            textcolour: Colors.white,
                            buttonColour: Colors.green,
                            description: "Aaj ki Kamae",
                            text: calculateCashIn(data) == '0.0'
                                ? ''
                                : calculateCashIn(data),
                          ),
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: ReuseableCard(
                            buttonColour: Colors.red,
                            textcolour: Colors.white,
                            description: "Moujouda Cash",
                            text: calculateCashOut(data) == '0.0'
                                ? ''
                                : calculateCashOut(data),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.size.height * 0.66,
                    child: Scrollbar(
                      thickness: 6.4,
                      interactive: true,
                      trackVisibility: true,
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          FittedBox(
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Text(
                                    'Date',
                                  ),
                                ),
                                DataColumn(
                                  numeric: true,
                                  label: Text(
                                    'Cash In',
                                  ),
                                ),
                                DataColumn(
                                  numeric: true,
                                  label: Text(
                                    'Cash Out',
                                  ),
                                ),
                              ],
                              rows: <DataRow>[
                                for (int i = 0; i < data.length; i++)
                                  DataRow(cells: [
                                    DataCell(Text(data[i].date.toString())),
                                    DataCell(
                                      Text(
                                        data[i].liye.toString(),
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        data[i].diye.toString(),
                                        style: const TextStyle(
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: ReusableButton(
                            color: Colors.red,
                            text: "Add Enteries",
                            onpress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CashInOutView(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
