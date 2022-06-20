import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/customer.dart';
import 'package:pay_qr/model/digi_khata/cash_model.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/utils/utility_helper.dart';
import 'package:pay_qr/view/main_views/digi_khata/add_customer/customer_record_view.dart';
import 'package:pay_qr/view/main_views/digi_khata/digi_nav.dart';

class AddCustomerRecord extends StatefulWidget {
  final CustomerModel? customer;
  final CashModel? record;
  final List<CashModel>? cashRecords;
  final bool isFromCashBook;
  final bool isMainDiye;
  const AddCustomerRecord({
    Key? key,
    this.customer,
    required this.isMainDiye,
    required this.isFromCashBook,
    this.record,
    this.cashRecords,
  }) : super(key: key);

  @override
  State<AddCustomerRecord> createState() => _AddCustomerRecordState();
}

class _AddCustomerRecordState extends State<AddCustomerRecord> {
  late DateTime date;
  late TextEditingController paisayController;
  late TextEditingController detailsController;
  @override
  void initState() {
    paisayController =
        TextEditingController(text: widget.record?.paisay.toString() ?? '');
    detailsController =
        TextEditingController(text: widget.record?.details.toString() ?? '');
    date = DateTime.tryParse(widget.record?.date ?? '') ?? DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      appBar: AppBar(
        title: Text(
          widget.isFromCashBook
              ? widget.isMainDiye
                  ? "Cash Out"
                  : 'Cash In'
              : widget.isMainDiye
                  ? "Maine Diye"
                  : 'Maine Liye',
          style: Get.textTheme.headline6,
        ),
        actions: [
          widget.record != null
              ? IconButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();

                    // logger.d(widget.record?.id);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: kScanBackColor,
                  ),
                )
              : const SizedBox()
        ],
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
                    label: Text(
                      Utility.getFormatedDate(date),
                      style: Get.textTheme.bodyLarge
                          ?.copyWith(color: kScanBackColor),
                    ),
                    icon: const Icon(
                      Icons.date_range_outlined,
                      color: kScanBackColor,
                    ),
                    onPressed: () async {
                      final pickerDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: DateTime.now(),
                          lastDate: DateTime(2030));
                      if (pickerDate != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(DateTime.now()),
                        );

                        if (time == null) {
                          showToast(msg: 'Please Select Time');
                          return;
                        } else {
                          setState(() {
                            date = Utility.combine(pickerDate, time);
                          });
                        }
                      }
                    }),
                const Spacer(),
                // ReusableButton(text: "Add bills"),
              ],
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: kWidth * 0.2),
              child: ElevatedButton(
                child: Text(
                  'Save',
                  style:
                      Get.textTheme.bodyLarge?.copyWith(color: kScanBackColor),
                ),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (paisayController.text.trim().isEmpty ||
                      detailsController.text.trim().isEmpty) {
                    showToast(msg: 'Please fill all  fields');
                    return;
                  }
                  var details = detailsController.text;
                  var paisay = paisayController.text;
                  // var id = const Uuid();
                  var record = CashModel(
                      date: date.toString(),
                      paisay: paisay,
                      details: details,
                      isMainDiye: widget.record == null
                          ? widget.isMainDiye
                          : widget.record!.isMainDiye,
                      id: widget.record == null
                          ? uid.v4()
                          : widget.record?.id ?? '');
                  logger.d(widget.record?.id);
                  if (widget.isFromCashBook == false) {
                    var records = widget.cashRecords;

                    records?.retainWhere(
                        (element) => widget.record!.id == element.id);
                    records?.add(record);
                    logger.d(records);
                    var customer =
                        widget.customer?.copyWith(cashRecords: records);
                    logger.d(customer);

                    bool result = widget.record == null
                        ? await digiController.updateCustomerRecord(
                            id: widget.customer!.id, record: record)
                        : await digiController.removeCustomerRecord(
                            customer: customer!);
                    if (!mounted) return;

                    if (result) {
                      Get.back();
                      // Get.off(
                      //   () => CustomerRecordsView(
                      //     customer: widget.customer!,
                      //   ),
                      // );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CustomerRecordsView(
                            customer: widget.customer!,
                          ),
                        ),
                      );
                    }
                  } else {
                    bool result = widget.record == null
                        ? await digiController.saveCashInOutKhata(
                            record: record)
                        : await digiController.updateCashInOutKhata(
                            record: record);
                    if (!mounted) return;

                    if (result) {
                      Get.back();
                      // Get.off(() => const DigiNavHome(
                      //       selectedScreen: 1,
                      //     ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DigiNavHome(
                                  selectedScreen: 1,
                                )),
                      );
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
