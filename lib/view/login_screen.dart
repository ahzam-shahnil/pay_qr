// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/Components/rounded_input_field.dart';
import 'package:pay_qr/Components/rounded_password_field.dart';
import 'package:pay_qr/config/constants.dart';
import 'package:pay_qr/services/show_toast.dart';
import 'package:pay_qr/view/signup_screen.dart';

import '../components/already_have_an_account_acheck.dart';
import '../controller/login_controller.dart';
import '../widgets/account_type_row.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final loginController = Get.find<LoginController>();

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
                    color: kPrimaryColor,
                  )),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'PayQr',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 45,
                    fontWeight: FontWeight.w700,
                  ),
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
                    textController: _emailController,
                    textInputType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                  ),
                  RoundedPasswordField(
                    autofillHints: const [AutofillHints.password],
                    textController: _passwordController,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Select Account Type:',
                    style:
                        Get.textTheme.headline6?.copyWith(color: kPrimaryColor),
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
                        var email = _emailController.text.trim();
                        var password = _passwordController.text.trim();
                        if (email.isEmpty || password.isEmpty) {
                          // show error toast
                          showToast(
                            msg: 'Please fill all fields',
                          );
                          return;
                        } else {
                          //? Calling Login
                          loginController.logIn(
                            context: context,
                            email: email,
                            password: password,
                          );
                        }
                      },
                      child: Text(
                        'Sign In',
                        style: Get.textTheme.headline6
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple.shade600,
                      )),
                  AlreadyHaveAnAccountCheck(
                      press: () => Get.to(() => SignupScreen()), login: true),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
