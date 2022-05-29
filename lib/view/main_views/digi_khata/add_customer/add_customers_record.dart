import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/digi_khata/cash_in_model.dart';
import 'package:pay_qr/model/digi_khata/customer.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';

import 'customer_record_view.dart';

class AddCustomerRecord extends StatefulWidget {
  final CustomerModel? customer;
  final bool isMainDiye;
  const AddCustomerRecord({Key? key, this.customer, required this.isMainDiye})
      : super(key: key);

  @override
  State<AddCustomerRecord> createState() => _AddCustomerRecordState();
}

class _AddCustomerRecordState extends State<AddCustomerRecord> {
  // final _firestore = FirebaseFirestore.instance;
  DateTime date = DateTime.now();
  late var formattedDate = DateFormat('d-MMM-yy').format(date);
  final TextEditingController paisayController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      appBar: AppBar(
        title: Text(
          widget.isMainDiye ? "Maine Diye" : 'Maine Liye',
          style: Get.textTheme.headline6,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: paisayController,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                  labelText: widget.isMainDiye ? "Maine Diye" : 'Maine Liye'),
            ),
            TextField(
              controller: detailsController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Tafseel"),
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.size.width * 0.2),
              child: ElevatedButton(
                child: const Text(
                  'Save',
                ),
                onPressed: () async {
                  if (paisayController.text.trim().isEmpty ||
                      detailsController.text.trim().isEmpty) {
                    showToast(msg: 'Please fill all  fields');
                    return;
                  }
                  var details = detailsController.text;
                  var paisay = paisayController.text;
                  var record = CashModel(
                    date: formattedDate,
                    paisay: double.parse(paisay),
                    details: details,
                    isMainDiye: widget.isMainDiye,
                  );
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
