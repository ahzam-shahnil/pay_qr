// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/Components/rounded_input_field.dart';
import 'package:pay_qr/Components/rounded_password_field.dart';
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
            shrinkWrap: true,
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
                  RoundedInputField(
                    hintText: 'Enter your email',
                    icon: Icons.email,
                    textController: loginController.emailController,
                    textInputType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                  RoundedPasswordField(
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
                  AccountTypeRow(loginController: loginController),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //trim for white spaces khtm krne k lea :D
                      loginController.loginUser(context);
                    },
                    child: Text(
                      'Sign In',
                      style: Get.textTheme.headline6
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  AlreadyHaveAnAccountCheck(
                      press: () => Get.to(() => const SignupScreen()),
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
