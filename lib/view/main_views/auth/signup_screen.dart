// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/Components/rounded_input_field.dart';
import 'package:pay_qr/Components/rounded_password_field.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/controller/login_controller.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../widgets/auth/account_type_row.dart';
import 'login_screen.dart';

// Package imports:

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

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
                    textCapitalization: TextCapitalization.words,
                    icon: Icons.person,
                    textController: signUpController.nameController,
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
                                textCapitalization: TextCapitalization.words,
                                hintText: 'Shop Name',
                                icon: Icons.shopping_basket_outlined,
                                textController:
                                    signUpController.shopNameController,
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
                    textController: signUpController.emailController,
                    autofillHints: const [AutofillHints.email],
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  RoundedPasswordField(
                    autofillHints: const [AutofillHints.newPassword],
                    textController: signUpController.passwordController,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    'Select Account Type:',
                    style: Get.textTheme.headline6,
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
                      signUpController.signUp(context);
                    },
                    child: Text(
                      'Sign Up',
                      style: Get.textTheme.headline6
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                  AlreadyHaveAnAccountCheck(
                      press: () => Get.to(() => const LoginScreen()),
                      login: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
