// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/utils/enum/user_type.dart';
import '../../controller/login_controller.dart';
import 'check_button.dart';

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
                  loginController.changeUser(UserType.merchant.toString()),
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
                  loginController.changeUser(UserType.user.toString()),
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
