import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/customer.dart';

import 'package:uuid/uuid.dart';

import 'customer_record_view.dart';

class AddCustomerContact extends StatefulWidget {
  // final Contact? contact;
  final String displayName;
  final String phoneNo;

  const AddCustomerContact({Key? key, this.displayName = '', this.phoneNo = ''})
      : super(key: key);

  @override
  State<AddCustomerContact> createState() => _AddCustomerContactState();
}

class _AddCustomerContactState extends State<AddCustomerContact> {
  late final TextEditingController displayNameController;
  @override
  void initState() {
    displayNameController = TextEditingController(text: widget.displayName);
    phoneNoController = TextEditingController(text: widget.phoneNo);
    super.initState();
  }

  late final TextEditingController phoneNoController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScanBackColor,
      appBar: AppBar(
        title: Text(
          'Add Customer',
          style: Get.textTheme.headline6,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: displayNameController,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    labelText: "Add Customer's name",
                    floatingLabelBehavior: FloatingLabelBehavior.auto),
              ),
              const SizedBox(
                height: 26.0,
              ),
              TextFormField(
                controller: phoneNoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    labelText: "Add Customer's contact No (optional)",
                    floatingLabelBehavior: FloatingLabelBehavior.auto),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.size.width * 0.3),
                child: ElevatedButton(
                  child: Text(
                    'Next',
                    style:
                        Get.textTheme.headline6?.copyWith(color: kPrimaryColor),
                  ),
                  onPressed: () async {
                    if (displayNameController.text.trim().isEmpty) {
                      return;
                    }
                    if (phoneNoController.text.trim().isEmpty) {
                      return;
                    }
                    //TODO: add constraint to not add duplicate contacts
                    var uid = const Uuid();
                    String id = uid.v4();
                    var customer = CustomerModel(
                        name: displayNameController.text.trim(),
                        phoneNo: phoneNoController.text.trim(),
                        cashRecords: [],
                        id: id);
                    bool result =
                        await digiController.saveCustomer(customer, context);
                    if (!result) {
                      return;
                    } else {
                      Get.back();
                      Get.to(() => CustomerRecordsView(
                            customer: customer,
                          ));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
