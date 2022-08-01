// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';
import 'package:pay_qr/components/rectangular_password_field.dart';
import 'package:pay_qr/components/rounded_rectangular_input_field.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/gen/assets.gen.dart';

import '../../../components/already_have_an_account_check.dart';
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
              SizedBox(
                height: kHeight * 0.085,
              ),
              Card(
                borderOnForeground: true,
                elevation: 6,
                clipBehavior: Clip.hardEdge,
                shape: const CircleBorder(),
                color: kTealColor,
                child: Center(
                  child: CircleAvatar(
                    // height: kHeight * 0.3,
                    radius: kWidth * 0.27,
                    backgroundColor: kTealColor,
                    child: Image.asset(
                      Assets.images.logoWn.path,
                      fit: BoxFit.cover,
                      // color: Colors.white,

                      alignment: Alignment.center,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  kAppName,
                  style: Get.textTheme.headline4
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

                  // Padding(
                  //   padding: EdgeInsets.only(right: kWidth * 0.1),
                  //   child: Align(
                  //     alignment: Alignment.centerRight,
                  //     child: TextButton(
                  //       onPressed: () async {
                  //         if (loginController.emailController.text
                  //             .trim()
                  //             .isEmpty) {
                  //           showSnackBar(
                  //               msg: 'Enter email for password reset.');
                  //           return;
                  //         }
                  //         var dialog = getProgressDialog(
                  //             title: 'Password Reset',
                  //             msg: 'Sending Password reset email',
                  //             context: context);
                  //         dialog.show();
                  //         try {
                  //           await auth.sendPasswordResetEmail(
                  //               email: loginController.emailController.text
                  //                   .trim());
                  //           showSnackBar(
                  //               msg: "Password reset Email Sent",
                  //               iconData: Icons.done_rounded,
                  //               backColor: Colors.green);
                  //         } on FirebaseAuthException {
                  //           showSnackBar(msg: 'Something Went Wrong.');
                  //         } catch (e) {
                  //           showSnackBar(msg: 'Something Went Wrong.');
                  //         } finally {
                  //           dialog.dismiss();
                  //         }
                  //       },
                  //       child: Text(
                  //         kPassWordForgotTxt,
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.w400,
                  //             color: kScanBackColor,
                  //             fontSize: Get.textTheme.bodyMedium?.fontSize),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: kHeight * 0.05,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      loginController.loginUser(context);
                    },
                    style: ElevatedButton.styleFrom(
                      primary: kScanBackColor,
                    ),
                    child: Text(
                      'Sign In',
                      style: Get.textTheme.bodyLarge
                          ?.copyWith(color: kPrimaryColor),
                    ),
                  ),
                  SizedBox(
                    height: kHeight * 0.05,
                  ),
                  AlreadyHaveAnAccountCheck(
                      press: () => Get.to(() => const SignupScreen(),
                          transition: Transition.leftToRightWithFade),
                      login: true),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
