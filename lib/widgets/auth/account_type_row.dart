// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';

// Project imports:
import 'package:pay_qr/utils/enum/user_type.dart';
import 'check_button.dart';

class AccountTypeRow extends StatelessWidget {
  const AccountTypeRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CheckButton(
              text: 'Merchant',
              textStyle: TextStyle(
                color: loginController.isMerchant()
                    ? kTextFieldColor
                    : kPrimaryColor,
              ),
              onPressed: () =>
                  loginController.changeUser(UserType.merchant.toString()),
              icon: Icon(
                loginController.isMerchant()
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_rounded,
                color: loginController.isMerchant()
                    ? kTextFieldColor
                    : kPrimaryColor,
              ),
              style: ElevatedButton.styleFrom(
                  primary: loginController.isMerchant()
                      ? kTealColor
                      : kTextFieldColor),
            ),
            const SizedBox(
              width: 20,
            ),
            CheckButton(
              text: 'User',
              textStyle: TextStyle(
                color:
                    loginController.isUser() ? kTextFieldColor : kPrimaryColor,
              ),
              onPressed: () =>
                  loginController.changeUser(UserType.user.toString()),
              icon: Icon(
                loginController.isUser()
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_rounded,
                color:
                    loginController.isUser() ? kTextFieldColor : kPrimaryColor,
              ),
              style: ElevatedButton.styleFrom(
                  primary:
                      loginController.isUser() ? kTealColor : kTextFieldColor),
            ),
          ],
        ));
  }
}
