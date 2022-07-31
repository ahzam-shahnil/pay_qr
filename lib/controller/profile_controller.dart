// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/controllers.dart';
// Project imports:
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/model/payment_model.dart';
import 'package:pay_qr/model/user_model.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/view/main_views/auth/login_screen.dart';

import '../config/app_constants.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();

  Future<void> updateProfile(UserModel userUpdate) async {
    logger.d('updating Profile');
    try {
      CollectionReference mainCollection;

      mainCollection = firestore.collection(kUserDb);

      User? user = AuthHelperFirebase.getCurrentFireBaseUser();
//? setting account password
      if (user != null) {
        logger.d(userUpdate.imageUrl);
        logger.i(userUpdate);
        if (userController.userModel.value.imageUrl != userUpdate.imageUrl) {
          user.updatePhotoURL(userUpdate.imageUrl);
        }
        if (userController.userModel.value.password != userUpdate.password) {
          await user.updatePassword(userUpdate.password!);
        }
        DocumentReference documentReferencer = mainCollection
            .doc(userController.userModel.value.uid)
            .collection(kProfileCollection)
            .doc(userController.userModel.value.uid);

        await documentReferencer.update(userUpdate.toMap()).whenComplete(() {
          showSnackBar(
            msg: "Profile Updated",
            backColor: Colors.green,
            iconData: Icons.done_rounded,
          );
        }).catchError((e) => throw (e));
      } else {
        logger.d('Current user is Null');
        throw Exception;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showSnackBar(msg: 'Email is already in Use');
      } else if (e.code == 'weak-password') {
        showSnackBar(msg: 'Password is weak');
      }
    } catch (e) {
      logger.i('catch sign up : $e');
      showSnackBar(msg: 'Something went wrong');
      rethrow;
    }
  }

  Future<void> logOut(BuildContext context) async {
    var progressDialog = getProgressDialog(
        context: context, msg: 'Please Wait', title: 'Signing Out');
    progressDialog.show();
    await AuthHelperFirebase.signOutAndCacheClear();

    progressDialog.dismiss();
    Get.offAll(() => const LoginScreen());
  }

  Future<bool> updateProfileBalance(PaymentModel paymentModel) async {
    try {
      User? user = AuthHelperFirebase.getCurrentFireBaseUser();
//? setting account password
      if (user != null) {
        try {
          return await AuthHelperFirebase.performPaymentTransaction(
              paymentModel);
        } catch (e) {
          logger.e(e);
          return false;
        }
      } else {
        logger.d('Current user is Null');
        return false;
        // throw Exception;
      }
    } on FirebaseAuthException catch (e) {
      logger.e(e);
      return false;
    } catch (e) {
      logger.e(e);
      showSnackBar(msg: 'Something went wrong');
      return false;
      // rethrow;
    }
  }

  DocumentReference? getProfileCollection() {
    try {
      User? user = AuthHelperFirebase.getCurrentFireBaseUser();
      final DocumentReference mainCollection;
      if (user != null) {
        mainCollection = firestore
            .collection(kUserDb)
            .doc(userController.userModel.value.uid)
            .collection(kProfileCollection)
            .doc(userController.userModel.value.uid);

        return mainCollection;
      }
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      rethrow;
    }
    return null;
  }
}
