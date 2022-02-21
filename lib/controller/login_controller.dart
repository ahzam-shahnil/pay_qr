import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pay_qr/services/auth_helper_firebase.dart';
import 'package:pay_qr/view/nav_home.dart';

import '../config/constants.dart';
import '../services/show_toast.dart';

class LoginController extends GetxController {
  // String? userUid;
  var isLoggedIn = false.obs;
  var userType = kUsers.merchant.toString().obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create storage
  final storage = const FlutterSecureStorage();
  Logger log = Logger();
  // final accountType = Get.find<AccountTypeController>();
  @override
  void onInit() {
    super.onInit();
    checkLogin();
  }

  void checkLogin() async {
    String? userCredential = await getLoggedInUser();
    userType.value = await getLoggedInUserType() ?? kUsers.merchant.toString();
    if (userCredential != null && userType.value.isNotEmpty) {
      isLoggedIn.value = true;
    } else {
      isLoggedIn.value = false;
    }
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

  Future<void> logIn({
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
          _mainCollection = _firestore
              .collection(kMerchantDb)
              .doc(userCredential.user?.uid)
              .collection(kProfileCollection);
        } else {
          _mainCollection = _firestore
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
        log.i("In Login Collection $collection");
        // collection.docs.map((e) {
        //   if (e["uid"] == (userCredential.user?.uid)) {
        //     isUser = true;
        //     // return;
        //   }
        // });
        if (collection.docs.isNotEmpty) {
          progressDialog.dismiss();
          if (isMerchant()) {
            Get.offAll(() => const TabPage());
          } else {
            Get.offAll(() => const TabPage());
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
      log.d(e.code);
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
    log.d(userCredential.credential?.token.toString());
    log.i(userCredential);
    await storage.write(key: kUserTypeSharedPrefKey, value: selected);
    await storage.write(
        key: kUserCredSharedPrefKey, value: userCredential.toString());
  }

  Future<String?> getLoggedInUser() async {
    return await storage.read(key: kUserCredSharedPrefKey);
    // AuthHelperFirebase.getCurrentUserUid();
  }

  Future<String?> getLoggedInUserType() async {
    return await storage.read(key: kUserTypeSharedPrefKey);
  }
}
