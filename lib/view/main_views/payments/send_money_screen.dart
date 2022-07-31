import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/components/rounded_rectangular_input_field.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/payment_model.dart';
import 'package:pay_qr/model/payment_qr_model.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({Key? key, required this.paymentQrModel})
      : super(key: key);
  final PaymentQrModel paymentQrModel;

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final TextEditingController amountController = TextEditingController();

  Future<bool> sendMoney() async {
    if (amountController.text.trim().isEmpty ||
        double.parse(amountController.text.trim()) <= 0) {
      showSnackBar(msg: 'Enter valid Amount');
      return false;
    }
    if (double.parse(amountController.text.trim()) >
        userController.userModel.value.balance) {
      showSnackBar(msg: 'Insufficient Balance in Account');
      return false;
    }
    var paymentModel = PaymentModel(
      amount: double.parse(amountController.text.trim()),
      date: DateTime.now().toString(),
      isSent: true,
      paymentId: uid.v4(),
      receiver: widget.paymentQrModel.name,
      receiverId: widget.paymentQrModel.uid,
      sender: userController.userModel.value.fullName!,
      senderId: userController.userModel.value.uid!,
    );
    bool result = await profileController.updateProfileBalance(paymentModel);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Money To'),
        backgroundColor: kPrimaryColor,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.paymentQrModel.name,
                style: Get.textTheme.headline6, textAlign: TextAlign.center),
            RoundedRectangleInputField(
              textCapitalization: TextCapitalization.none,
              hintText: 'Enter amount to Send',
              onSubmitted: (value) async {
                var progressDialog = getProgressDialog(
                    context: context,
                    msg: 'Please Wait',
                    title: 'Sending Money');
                progressDialog.show();
                bool result = await sendMoney();
                progressDialog.dismiss();
                if (result) {
                  showSnackBar(
                    msg: "Success",
                    iconData: Icons.done_rounded,
                  );
                } else {
                  showSnackBar(msg: "Failure");
                }
              },
              textInputAction: TextInputAction.send,
              textController: amountController,
              isAutoFocus: true,
              textInputType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () async {
                var progressDialog = getProgressDialog(
                    context: context,
                    msg: 'Please Wait',
                    title: 'Sending Money');
                progressDialog.show();
                bool result = await sendMoney();
                progressDialog.dismiss();
                if (result) {
                  showSnackBar(
                    msg: "Success",
                    iconData: Icons.done_rounded,
                  );
                } else {
                  showSnackBar(msg: "Failure");
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                primary: kTealColor,
              ),
              child: Text(
                'Send',
                style: Get.textTheme.headline6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
