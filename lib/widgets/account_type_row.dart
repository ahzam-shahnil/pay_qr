import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/constants.dart';
import 'package:pay_qr/widgets/check_button.dart';

import '../controller/login_controller.dart';

class AccountTypeRow extends StatelessWidget {
  const AccountTypeRow({
    Key? key,
    required this.loginController,
  }) : super(key: key);

  final LoginController loginController;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CheckButton(
              text: 'Merchant',
              onPressed: () =>
                  loginController.changeUser(kUsers.merchant.toString()),
              icon: Icon(loginController.isMerchant()
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank_rounded),
              style: ElevatedButton.styleFrom(
                  primary: loginController.isMerchant()
                      ? Colors.blue
                      : Colors.deepPurple.shade200),
            ),
            const SizedBox(
              width: 20,
            ),
            CheckButton(
              text: 'User',
              onPressed: () =>
                  loginController.changeUser(kUsers.user.toString()),
              icon: Icon(loginController.isUser()
                  ? Icons.check_box_outlined
                  : Icons.check_box_outline_blank_rounded),
              style: ElevatedButton.styleFrom(
                  primary: loginController.isUser()
                      ? Colors.blue
                      : Colors.deepPurple.shade200),
            ),
            // CustomCheckButton(icon: ),
            // const SizedBox(width: 15),
            // choiceButton('User', 1),
          ],
        ));
  }
}
