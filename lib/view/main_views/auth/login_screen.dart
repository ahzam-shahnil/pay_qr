// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pay_qr/components/rectangular_password_field.dart';
import 'package:pay_qr/components/rounded_rectangular_input_field.dart';
import 'package:pay_qr/config/app_constants.dart';

import 'package:pay_qr/config/controllers.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../widgets/auth/account_type_row.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: ListView(
          primary: true,
            children: [
              const SizedBox(
                height: 100,
              ),
              Obx(() => Icon(
                    loginController.isMerchant()
                        ? Icons.shopping_basket_outlined
                        : Icons.person_outline_rounded,
                    size: 150,
                    color: Colors.white,
                  )),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'PayQr',
                  style: Get.textTheme.headline3
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              AutofillGroup(
                child: Column(children: [
                  RoundedRectangleInputField(
                    hintText: 'Enter your email',
                    textController: loginController.emailController,
                    textInputType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                  RectangularPasswordField(
                    autofillHints: const [AutofillHints.password],
                    textController: loginController.passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Select Account Type:',
                    style: Get.textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const AccountTypeRow(),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loginController.loginUser(context);
                    },
                    // style: ElevatedButton.styleFrom(
                    //   primary: kLightBackColor,
                    // ),
                    child: Text(
                      'Sign In',
                      style: Get.textTheme.headline6
                          ?.copyWith(color: kPrimaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AlreadyHaveAnAccountCheck(
                      press: () => Get.to(() => const SignupScreen(),
                          transition: Transition.leftToRightWithFade),
                      login: true),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
