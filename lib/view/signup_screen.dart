// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:

import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:pay_qr/Components/rounded_input_field.dart';
import 'package:pay_qr/Components/rounded_password_field.dart';
import 'package:pay_qr/config/constants.dart';
import 'package:pay_qr/controller/login_controller.dart';
import 'package:pay_qr/controller/sign_up_controller.dart';

import 'package:pay_qr/view/login_screen.dart';
import 'package:pay_qr/widgets/account_type_row.dart';
import '../components/already_have_an_account_acheck.dart';
import '../services/show_toast.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final Logger log = Logger();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final signUpController = Get.find<SignUpController>();
  final loginController = Get.find<LoginController>();
  Future<void> _signUp(BuildContext context) async {
    var fullName = _nameController.text.trim();
    var shopName = _shopNameController.text.trim();
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      // show error toast

      showToast(
        msg: 'Please fill all fields',
      );
      return;
    }

    if (password.length < 6) {
      showToast(msg: 'Weak Password, at least 6 characters are required');

      return;
    }

    //? In case of no error , we do sign up
    signUpController.signUpUser(
      context: context,
      email: email,
      password: password,
      fullName: fullName,

      //* shop Name is only available for Merchant Account
      shopName: shopName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: ListView(
          // padding: const EdgeInsets.all(20.0),
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 25.0,
            ),
            AutofillGroup(
              child: Column(
                children: [
                  RoundedInputField(
                    hintText: 'Full Name',
                    icon: Icons.person,
                    textController: _nameController,
                    textInputType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                  ),
                  Obx(
                    () => loginController.isMerchant()
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 12.0,
                              ),
                              RoundedInputField(
                                hintText: 'Shop Name',
                                icon: Icons.shopping_basket_outlined,
                                textController: _shopNameController,
                                textInputType: TextInputType.name,
                                autofillHints: const [
                                  AutofillHints.organizationName
                                ],
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  RoundedInputField(
                    hintText: 'Email',
                    icon: Icons.email,
                    textController: _emailController,
                    autofillHints: const [AutofillHints.email],
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  RoundedPasswordField(
                    autofillHints: const [AutofillHints.newPassword],
                    textController: _passwordController,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'Select Account Type:',
                    style:
                        Get.textTheme.headline6?.copyWith(color: kPrimaryColor),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  AccountTypeRow(loginController: Get.find<LoginController>()),
                  const SizedBox(
                    height: 25.0,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        // TextInput.finishAutofillContext();
                        _signUp(context);
                      },
                      child: Text(
                        'Sign Up',
                        style: Get.textTheme.headline6
                            ?.copyWith(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple.shade600,
                      )),
                  AlreadyHaveAnAccountCheck(
                      press: () => Get.to(() => const LoginScreen()),
                      login: false),
                  // TextButton(
                  //     onPressed: () => Get.offAll(() => const LoginScreen()),
                  //     child: Text(
                  //       'Already have an account ? Sign In',
                  //       style: Get.textTheme.headline6?.copyWith(
                  //           color: Colors.blue, fontWeight: FontWeight.bold),
                  //     ),
                  //     style: TextButton.styleFrom(
                  //       primary: Colors.deepPurple.shade600,
                  //     )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
