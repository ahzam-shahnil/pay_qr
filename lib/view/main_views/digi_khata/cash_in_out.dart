import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/widgets/digi_khata/reuseable_button.dart';

class CashInOut extends StatefulWidget {
  const CashInOut({Key? key}) : super(key: key);

  @override
  _CashInOutState createState() => _CashInOutState();
}

class _CashInOutState extends State<CashInOut> {
  DateTime date = DateTime.now();
  late var formattedDate = DateFormat('d-MMM-yy').format(date);
  late String amountCashout;
  late String detailCashOut;
  late String dateCashOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      appBar: AppBar(
        title: const Text("Cash Out"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                amountCashout = value;
              },
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Cash in"),
            ),
            TextField(
              onChanged: (value) {
                detailCashOut = value;
              },
              decoration: const InputDecoration(labelText: "Cash out"),
            ),
            const SizedBox(
              height: 28.0,
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  label: Text(formattedDate),
                  icon: const Icon(Icons.date_range_outlined),
                  onPressed: () async {
                    DateTime? _newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2030),
                    );
                    setState(() {
                      if (_newDate == null) {
                        return;
                      } else {
                        formattedDate = DateFormat('d-MMM-yy').format(_newDate);
                      }
                    });
                  },
                ),
                const Spacer(),
                // ReusableButton(text: "Add bills"),
              ],
            ),
            const Spacer(),
            ReusableButton(
              color: Colors.green,
              text: 'Save',
              onpress: () async {
                await firestore.collection('CASHINCASHOUT').add(
                  {
                    'CASHIN': amountCashout,
                    'CASHOUT': detailCashOut,
                    'DATE': formattedDate
                  },
                );
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
