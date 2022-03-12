// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/view/main_views/home/nav_home.dart';
import '../config/app_constants.dart';
import '../config/firebase.dart';
import '../utils/toast_dialogs.dart';

class LoginController extends GetxController {
  static LoginController instance = Get.find();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isLoggedIn = false.obs;

  var userType = kUsers.merchant.toString().obs;

  Future<void> checkLogin() async {
    String? userCredential = await getLoggedInUser();
    userType.value = await getLoggedInUserType() ?? kUsers.merchant.toString();
    if (userCredential != null && userType.value.isNotEmpty) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }

    // hideLoading();
    // showToast(msg: token!);
    // showToast(msg: isLoggedIn.toString());
  }

  bool isMerchant() {
    return userType.value == kUsers.merchant.toString();
  }

  bool isUser() {
    return userType.value == kUsers.user.toString();
  }

  void changeUser(String user) {
    userType.value = user;
  }

  loginUser(BuildContext context) {
    var email = emailController.text.trim();
    var password = passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      // show error toast
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
    // request to firebase auth

    var progressDialog = getProgressDialog(
        context: context, msg: 'Please Wait', title: 'Logging In');
    progressDialog.show();

    try {
      UserCredential? userCredential =
          await AuthHelperFirebase.logInUser(email, password);

      if (userCredential?.user?.emailVerified == false) {
        progressDialog.setMessage(const Text("Verify your email to login."));
        progressDialog.dismiss();
        throw FirebaseAuthException(code: 'verify_email');
      }
      if (userCredential?.user != null) {
        //*saving User to secure storageR
        storeTokenAndData(userCredential!, userType.value.toString());
        // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
        final CollectionReference _mainCollection;

        //* Checking User to store Data
        if (isMerchant()) {
          _mainCollection = firebaseFirestore
              .collection(kMerchantDb)
              .doc(userCredential.user?.uid)
              .collection(kProfileCollection);
        } else {
          _mainCollection = firebaseFirestore
              .collection(kUserDb)
              .doc(userCredential.user?.uid)
              .collection(kProfileCollection);
        }
        // bool? isUser;
        var collection = await _mainCollection
            .where(kUserIdDoc, isEqualTo: userCredential.user?.uid)
            .get();

        // await collection.then((QuerySnapshot querySnapshot) => {

        //       querySnapshot.docs.forEach((doc) {

        //       })
        //     });
        logger.i("In Login Collection $collection");
        // collection.docs.map((e) {
        //   if (e["uid"] == (userCredential.user?.uid)) {
        //     isUser = true;
        //     // return;
        //   }
        // });
        if (collection.docs.isNotEmpty) {
          progressDialog.dismiss();
          if (isMerchant()) {
            Get.offAll(() => const NavHomeScreen());
          } else {
            Get.offAll(() => const NavHomeScreen());
          }
        } else {
          progressDialog.dismiss();
          showToast(
            msg: 'User not found',
          );
        }
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
      debugPrint('e : $e');
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
}
