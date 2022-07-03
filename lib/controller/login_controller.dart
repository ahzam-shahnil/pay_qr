// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/user_model.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/view/main_views/home/nav_home.dart';
import '../config/app_constants.dart';
import '../config/firebase.dart';
import '../utils/toast_dialogs.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> initiateUserStream() async {
    if (userController.firebaseUser.value != null) {
      userController.bindUserStream();
    }
  }

  loginUser(BuildContext context) {
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showToast(
        msg: 'Please fill all fields',
      );
      return;
    } else {
      //? Calling Login
      _logIn(
        context: context,
        email: email,
        password: password,
      );
    }
  }

  Future<void> _logIn({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    var progressDialog = getProgressDialog(
        context: context, msg: 'Please Wait', title: 'Logging In');
    progressDialog.show();

    try {
      UserCredential? userCredential =
          await AuthHelperFirebase.logInUser(email, password);

      //TODO: enable this when firebase email is up
      // User? userFirebase = userCredential?.user;
      // if (userFirebase != null && !userFirebase.emailVerified) {
      //   await userFirebase.sendEmailVerification();
      //   progressDialog.setMessage(const Text("Verify your email to login."));

      //   progressDialog.dismiss();

      //   // await userCredential?.user?.sendEmailVerification();
      //   throw FirebaseAuthException(code: 'verify_email');
      // }
      logger.d(userCredential?.user);
      if (userCredential?.user != null) {
        await initiateUserStream();
        //?saving User to secure storageR
        final DocumentReference mainCollection;
        mainCollection = firestore
            .collection(kUserDb)
            .doc(userController.firebaseUser.value?.uid)
            .collection(kProfileCollection)
            .doc(userController.firebaseUser.value?.uid);

        var collection = await mainCollection.get();

        logger.i("In Login Collection ${UserModel.fromSnapshot(collection)}");

        if (collection.exists) {
          progressDialog.dismiss();
          resetTextControllers();
          Get.offAll(() => const NavHomeScreen());
        } else {
          progressDialog.dismiss();
          AuthHelperFirebase.signOutAndCacheClear();
          showToast(
            msg: 'User not found',
          );
        }
      } else {
        AuthHelperFirebase.signOutAndCacheClear();
      }
    } on FirebaseAuthException catch (e) {
      progressDialog.dismiss();
      logger.d(e.code);
      if (e.code == 'user-not-found') {
        showToast(
          msg: 'User not found',
        );
      } else if (e.code == 'wrong-password') {
        showToast(
          msg: 'Wrong password',
        );
      } else if (e.code == 'verify_email') {
        showToast(msg: "Verify your Email to Login");
      } else if (e.code == 'too-many-requests') {
        showToast(msg: "Too many requests from you. Slow down");
      }
    } catch (e) {
      progressDialog.dismiss();
      showToast(
        msg: 'Something went wrong',
      );
      logger.e(e);
    }
  }

  Future<void> storeTokenAndData(
      UserCredential userCredential, String selected) async {
    logger.d(userCredential.credential?.token.toString());
    logger.i(userCredential);
    await storagePrefs.write(key: kUserTypeSharedPrefKey, value: selected);
    await storagePrefs.write(
        key: kUserCredSharedPrefKey, value: userCredential.toString());
  }

  Future<String?> getLoggedInUser() async {
    return await storagePrefs.read(key: kUserCredSharedPrefKey);
    // AuthHelperFirebase.getCurrentUserUid();
  }

  Future<String?> getLoggedInUserType() async {
    return await storagePrefs.read(key: kUserTypeSharedPrefKey);
  }

  resetTextControllers() {
    emailController.clear();
    passwordController.clear();
  }
}
