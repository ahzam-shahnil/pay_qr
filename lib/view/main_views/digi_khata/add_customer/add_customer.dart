import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/digi_khata/customer.dart';
import 'package:pay_qr/widgets/digi_khata/reuseable_button.dart';
import 'package:uuid/uuid.dart';

import 'add_customers_record.dart';

class AddCustomer extends StatefulWidget {
  final Contact? contact;
  const AddCustomer({Key? key, this.contact}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  String? customerName;
  String? customerContact;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      appBar: AppBar(
        title: const Text('Add Customer'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: widget.contact?.displayName ?? '',
                onChanged: (value) {
                  customerName = value;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    labelText: "Add Customer's name",
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
              const SizedBox(
                height: 26.0,
              ),
              TextFormField(
                initialValue: widget.contact?.phones?.first.value ?? '',
                onChanged: (value) {
                  customerContact = value;
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: "Add Customer's contact No (optional)",
                    floatingLabelBehavior: FloatingLabelBehavior.auto),
              ),
              const Spacer(),
              ReusableButton(
                text: 'Next',
                onpress: () async {
                  //TODO: add constraint to not add duplicate contacts
                  var uid = const Uuid();
                  String id = uid.v4();
                  var customer = CustomerModel(
                      name: customerName ?? widget.contact?.displayName ?? '',
                      phoneNo: customerContact ??
                          widget.contact?.phones?.first.value ??
                          '',
                      cashRecords: [],
                      id: id);
                  bool result = await digiController.saveCustomer(customer);
                  if (!result) {
                    return;
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddCustomerRecord(
                                customer: customer,
                              )),
                    );
                  }

                  // Get.to(() => AddCustomerRecord(
                  //       customer: customer,
                  //     ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
