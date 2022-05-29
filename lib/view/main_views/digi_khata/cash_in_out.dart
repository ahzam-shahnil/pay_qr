import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/utils/utility_helper.dart';
import 'package:pay_qr/widgets/digi_khata/reuseable_button.dart';

class CashInOutView extends StatefulWidget {
  const CashInOutView({Key? key}) : super(key: key);

  @override
  State<CashInOutView> createState() => _CashInOutViewState();
}

class _CashInOutViewState extends State<CashInOutView> {
  DateTime date = DateTime.now();
  late var formattedDate = Utility.getFormatedDate(date);

  final TextEditingController amountCashIn = TextEditingController();
  final TextEditingController amountCashOut = TextEditingController();

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
              controller: amountCashIn,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Cash in"),
            ),
            TextField(
              controller: amountCashOut,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
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
                    DateTime? newDate = await showDatePicker(
                      context: context,
                      initialDate: date,
                      firstDate: DateTime(2022),
                      lastDate: DateTime(2030),
                    );

                    if (newDate == null) {
                      return;
                    } else {
                      setState(() {
                        formattedDate = Utility.getFormatedDate(newDate);
                      });
                    }
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
                if (amountCashIn.text.trim().isEmpty ||
                    amountCashOut.text.trim().isEmpty) {
                  showToast(msg: 'Please fill all fields');
                  return;
                }
                double diye = double.parse(amountCashOut.text.trim());
                double liye = double.parse(amountCashIn.text.trim());
                //Todo: make cash in model
                // digiController.saveCashInOutKhata(
                //     CashModel(date: formattedDate, paisay: liye, diye: diye));
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}
