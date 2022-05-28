import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/digi_khata/cash_in_model.dart';
import 'package:pay_qr/model/digi_khata/customer.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/widgets/digi_khata/reuseable_button.dart';

import '../customer_record_view.dart';

class AddCustomerRecord extends StatefulWidget {
  final CustomerModel? customer;
  const AddCustomerRecord({Key? key, this.customer}) : super(key: key);

  @override
  _AddCustomerRecordState createState() => _AddCustomerRecordState();
}

class _AddCustomerRecordState extends State<AddCustomerRecord> {
  // final _firestore = FirebaseFirestore.instance;
  DateTime date = DateTime.now();
  late var formattedDate = DateFormat('d-MMM-yy').format(date);
  final TextEditingController paisayDiye = TextEditingController();
  final TextEditingController paisayLiye = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      appBar: AppBar(
        title: const Text("Customer Khata"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: paisayDiye,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(labelText: "Maine Diye"),
            ),
            TextField(
              controller: paisayLiye,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Maine Liye"),
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
                    setState(() {
                      if (newDate == null) {
                        return;
                      } else {
                        formattedDate = DateFormat('d-MMM-yy').format(newDate);
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
                if (paisayDiye.text.trim().isEmpty ||
                    paisayLiye.text.trim().isEmpty) {
                  showToast(msg: 'Please fill all  fields');
                  return;
                }
                var liye = paisayLiye.text;
                var diye = paisayDiye.text;
                var record = CashModel(
                    date: formattedDate,
                    liye: double.parse(liye),
                    diye: double.parse(diye));
                logger.d(record);
                await digiController.updateCustomerRecord(
                    id: widget.customer!.id, record: record);
//TODO: replacing the screen customers
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CustomerRecordsView(
                            customer: widget.customer!,
                          )),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
