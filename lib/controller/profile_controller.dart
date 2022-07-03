// Flutter imports:

import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

      // //* Checking User to store Data
      // if (currentUser.value.isMerchant!) {
      //   mainCollection = firestore.collection(kUserDb);
      // } else {
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
          // userController.userModel.value = userUpdate;
          showToast(
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
        showToast(msg: 'Email is already in Use');
      } else if (e.code == 'weak-password') {
        showToast(msg: 'Password is weak');
      }
    } catch (e) {
      logger.i('catch sign up : $e');
      showToast(msg: 'Something went wrong');
      rethrow;
    }
  }

  Future<void> logOut(BuildContext context) async {
    var progressDialog = getProgressDialog(
        context: context, msg: 'Please Wait', title: 'Signing Out');
    progressDialog.show();
    await AuthHelperFirebase.signOutAndCacheClear();
    // await loginController.initiateUserStream();
    progressDialog.dismiss();
    Get.offAll(() => const LoginScreen());
  }

  Future<bool> updateProfileBalance(PaymentModel paymentModel) async {
    try {
      // CollectionReference mainCollection;

      // mainCollection = firestore.collection(kUserDb);

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
      showToast(msg: 'Something went wrong');
      return false;
      // rethrow;
    }
  }

  // Future<QuerySnapshot<Object?>?> getProfile() async {
  //   showLoading();
  //   try {
  //     final DocumentReference? mainCollection = getProfileCollection();
  //     if (mainCollection != null) {
  //       var data = await mainCollection.get();

  //       // await collection.then((QuerySnapshot querySnapshot) => {
  //       //       for (final document in querySnapshot.docs) {document.data()}
  //       //     });

  //       // var users = data.docs.map((e) => UserModel.fromSnapshot(e));

  //       // log.i(users);
  //       // users.isEmpty;
  //       if (data.exists) {
  //         // progressDialog.dismiss();

  //         // Get.offAll(() => const NavHomeScreen());
  //       }
  //       hideLoading();
  //       return null;
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     // progressDialog.dismiss();
  //     hideLoading();
  //     logger.d(e.code);
  //     if (e.code == 'user-not-found') {
  //       showToast(
  //         msg: 'User not found',
  //       );
  //     } else if (e.code == 'wrong-password') {
  //       showToast(
  //         msg: 'Wrong password',
  //       );
  //     } else if (e.code == 'verify_email') {
  //       showToast(msg: "Verify your Email to Login");
  //     } else if (e.code == 'too-many-requests') {
  //       showToast(msg: "Too many requests from you. Slow down");
  //     }
  //   } catch (e) {
  //     // progressDialog.dismiss();
  //     hideLoading();
  //     showToast(
  //       msg: 'Something went wrong',
  //     );
  //     debugPrint('e : $e');
  //   }
  //   return null;
  // }

  DocumentReference? getProfileCollection() {
    try {
      User? user = AuthHelperFirebase.getCurrentFireBaseUser();
      final DocumentReference mainCollection;
      if (user != null) {
        //* Checking User to store Data
        // if (loginController.isMerchant()) {
        //   mainCollection = firestore
        //       .collection(kMerchantDb)
        //       .doc(user.uid)
        //       .collection(kProfileCollection);
        // } else {
        mainCollection = firestore
            .collection(kUserDb)
            .doc(userController.userModel.value.uid)
            .collection(kProfileCollection)
            .doc(userController.userModel.value.uid);
        // }
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
