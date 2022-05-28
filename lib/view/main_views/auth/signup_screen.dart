// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:pay_qr/components/rectangular_password_field.dart';
import 'package:pay_qr/components/rounded_rectangular_input_field.dart';
import 'package:pay_qr/config/app_constants.dart';

// Project imports:
import 'package:pay_qr/config/controllers.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../widgets/auth/account_type_row.dart';

// Package imports:

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Sign Up', style: Get.textTheme.headline5),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
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
                  RoundedRectangleInputField(
                    hintText: 'Full Name',
                    textCapitalization: TextCapitalization.words,
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
                              RoundedRectangleInputField(
                                textCapitalization: TextCapitalization.words,
                                hintText: 'Shop Name',
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
                  RoundedRectangleInputField(
                    hintText: 'Email',
                    textController: signUpController.emailController,
                    autofillHints: const [AutofillHints.email],
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  RectangularPasswordField(
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
                  const AccountTypeRow(),
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
                      style: Get.textTheme.headline6?.copyWith(
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  AlreadyHaveAnAccountCheck(
                      press: () => Get.back(), login: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
