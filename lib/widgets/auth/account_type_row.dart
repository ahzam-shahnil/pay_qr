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
                  color: signUpController.isMerchant()
                      ? kTextFieldColor
                      : kScanBackColor,
                  fontWeight: FontWeight.bold),
              onPressed: () =>
                  signUpController.changeUser(UserType.merchant.toString()),
              icon: Icon(
                signUpController.isMerchant()
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_rounded,
                color: signUpController.isMerchant()
                    ? kTextFieldColor
                    : kScanBackColor,
              ),
              style: ElevatedButton.styleFrom(
                primary: signUpController.isMerchant()
                    ? kScanBackColor
                    : kTextFieldColor,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            CheckButton(
              text: 'User',
              textStyle: TextStyle(
                  color: signUpController.isUser()
                      ? kTextFieldColor
                      : kScanBackColor,
                  fontWeight: FontWeight.bold),
              onPressed: () =>
                  signUpController.changeUser(UserType.user.toString()),
              icon: Icon(
                signUpController.isUser()
                    ? Icons.check_box_outlined
                    : Icons.check_box_outline_blank_rounded,
                color: signUpController.isUser()
                    ? kTextFieldColor
                    : kScanBackColor,
              ),
              style: ElevatedButton.styleFrom(
                  primary: signUpController.isUser()
                      ? kScanBackColor
                      : kTextFieldColor),
            ),
          ],
        ));
  }
}
