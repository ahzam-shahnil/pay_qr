import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/digi_khata/customer.dart';
import 'package:pay_qr/widgets/digi_khata/reusable_card.dart';
import 'package:pay_qr/widgets/digi_khata/reuseable_button.dart';

import '../../../model/digi_khata/cash_in_model.dart';
import 'add_customer/add_customers_record.dart';

class CustomerRecordsView extends StatefulWidget {
  final CustomerModel customer;
  const CustomerRecordsView({Key? key, required this.customer})
      : super(key: key);

  @override
  State<CustomerRecordsView> createState() => _CustomerRecordsViewState();
}

class _CustomerRecordsViewState extends State<CustomerRecordsView> {
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

  // DateTime date = DateTime.now();
  // late var formattedDate = DateFormat('d-MMM-yy').format(date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: FutureBuilder(
        future: digiController.getCustomerSpecificRecord(widget.customer.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasData) {
            var data = snapshot.data as CustomerModel;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
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
                            buttonColour: Colors.green,
                            text: "Maine Lainy Hain",
                            description: '',
                            // description: addMoney(snapshot, 'DIYE') == '0'
                            //     ? ''
                            //     : addMoney(snapshot, 'DIYE'),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: ReuseableCard(
                              buttonColour: Colors.red,
                              textcolour: Colors.white,
                              text: "Maine Dainy hain",
                              description: ''
                              // addMoney(snapshot, 'LIYE') == '0'
                              //     ? ''
                              //     : addMoney(snapshot, 'LIYE'),
                              ),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    // style: TextButton.styleFrom(),
                    icon: CircleAvatar(
                      backgroundColor: Colors.blueGrey.shade200,
                      child: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                      ),
                    ),
                    label: Text(
                      data.name,
                      style: Get.textTheme.headline6?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  // const Spacer(),
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
                                  label: Text(
                                    'Maine Diye',
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Maine Liye',
                                  ),
                                ),
                              ],
                              rows: <DataRow>[
                                for (int i = 0;
                                    i < data.cashRecords.length;
                                    i++)
                                  DataRow(cells: [
                                    DataCell(Text(
                                        data.cashRecords[i].date.toString())),
                                    DataCell(
                                      Text(
                                        data.cashRecords[i].diye.toString(),
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        data.cashRecords[i].liye.toString(),
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
                            text: "Liye or Diye",
                            onpress: () {
                              Get.to(() => AddCustomerRecord(
                                    customer: widget.customer,
                                  ));
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
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
