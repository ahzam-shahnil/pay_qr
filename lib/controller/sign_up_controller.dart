// Flutter imports:
// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Project imports:
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/utils/enum/user_type.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';

import '../config/app_constants.dart';
import '../model/user_model.dart';

// Project imports:

class SignUpController extends GetxController {
  static SignUpController instance = Get.find();
  var userType = UserType.merchant.toString().obs;

  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> signUp(BuildContext context) async {
    var fullName = nameController.text.trim();
    var shopName = shopNameController.text.trim();
    var email = emailController.text.trim();
    var password = passwordController.text.trim();

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
      // show error toast

      showSnackBar(
        msg: 'Please fill all fields',
      );
      return;
    }

    if (password.length < 6) {
      showSnackBar(msg: 'Weak Password, at least 6 characters are required');

      return;
    }

    //? In case of no error , we do sign up
    _signUpUser(
      context: context,
      email: email,
      password: password,
      fullName: fullName,
      shopName: shopName,
    );
  }

  Future<void> _signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String fullName,
    String? shopName,
  }) async {
    var progressDialog = getProgressDialog(
        context: context, msg: 'Please wait', title: 'Signing Up');

    progressDialog.show();
    resetTextControllers();
    try {
      UserCredential? userCredential =
          await AuthHelperFirebase.signUp(email, password);

      if (userCredential?.user != null) {
        final CollectionReference mainCollection;
        UserModel? user;

        String? uid = userCredential?.user!.uid;

        mainCollection = firestore.collection(kUserDb);
        //?Make models for Shop keeper and user sign up
        user = UserModel(
          fullName: fullName,
          email: email,
          password: password,
          uid: uid!,
          isMerchant: isMerchant(),
          shopName: isMerchant() ? shopName ?? '' : '',
          cart: [],
          imageUrl: '',
          balance: 0,
        );

        //* Here we get the ref to collection of profile
        DocumentReference documentReferencer =
            mainCollection.doc(uid).collection(kProfileCollection).doc(uid);

        //? Converting data to map for Shop keeper and user sign up
        Map<String, dynamic>? data = user.toMap();

        await documentReferencer
            .set(data)
            .whenComplete(() => showSnackBar(
                msg: "Success",
                backColor: Colors.green,
                iconData: Icons.done_rounded))
            .catchError((e) => logger.e(e));
        // progressDialog.setMessage(const Text('Verify email is sent.'));
        // resetTextControllers();
        //* sending verify email
        await userCredential?.user?.sendEmailVerification();

        Future.delayed(const Duration(milliseconds: 200));
        progressDialog.dismiss();

        AuthHelperFirebase.signOutAndCacheClear();
        Get.back();
      } else {
        showSnackBar(msg: 'Failed');
      }

      progressDialog.dismiss();
    } on FirebaseAuthException catch (e) {
      progressDialog.dismiss();
      if (e.code == 'email-already-in-use') {
        showSnackBar(msg: 'Email is already in Use');
      } else if (e.code == 'weak-password') {
        showSnackBar(msg: 'Password is weak');
      }
    } catch (e) {
      progressDialog.dismiss();
      logger.i('catch sign up : $e');
      showSnackBar(msg: 'Something went wrong');
    }
  }

  void changeUser(String user) {
    userType.value = user;
  }

  bool isMerchant() {
    return userType.value == UserType.merchant.toString();
  }

  bool isUser() {
    return userType.value == UserType.user.toString();
  }

  resetTextControllers() {
    emailController.clear();
    nameController.clear();
    shopNameController.clear();
    passwordController.clear();
  }
}
