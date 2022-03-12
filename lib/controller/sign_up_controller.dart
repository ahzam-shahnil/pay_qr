// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import '../config/app_constants.dart';
import '../model/user_model.dart';

// Project imports:

class SignUpController extends GetxController {
  static SignUpController instance = Get.find();

  // final loginController = Get.find<LoginController>();
  // Create storage
  // final storage = const FlutterSecureStorage();
  // final Logger log = Logger();

  // final Logger log = Logger();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController shopNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // final signUpController = Get.find<SignUpController>();
  // final loginController = Get.find<LoginController>();
  Future<void> signUp(BuildContext context) async {
    var fullName = nameController.text.trim();
    var shopName = shopNameController.text.trim();
    var email = emailController.text.trim();
    var password = passwordController.text.trim();

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
    _signUpUser(
      context: context,
      email: email,
      password: password,
      fullName: fullName,

      //* shop Name is only available for Merchant Account
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

    try {
      UserCredential? userCredential =
          await AuthHelperFirebase.signUp(email, password);
      logger.i('before database');

      if (userCredential?.user != null) {
        final CollectionReference _mainCollection;
        UserModel? _user;
        // Merchant? _merchant;
        String? uid = userCredential?.user!.uid;

        //* Checking User to store Data
        if (loginController.isMerchant()) {
          _mainCollection = firebaseFirestore.collection(kMerchantDb);
          _user = UserModel(
            fullName: fullName,
            email: email,
            password: password,
            uid: uid!,
            isMerchant: true,
            shopName: shopName,
            cart: [],
          );
        } else {
          _mainCollection = firebaseFirestore.collection(kUserDb);
          //?Make models for Shop keeper and user sign up
          _user = UserModel(
            fullName: fullName,
            email: email,
            password: password,
            uid: uid!,
            isMerchant: false,
            cart: [],
          );
        }

        logger.i('after database');
//? Here we get the ref to collection of profile
        DocumentReference documentReferencer =
            _mainCollection.doc(uid).collection(kProfileCollection).doc(uid);

        //? Converting data to map for Shop keeper and user sign up
        Map<String, dynamic>? data = _user.toMap();
        // loginController.isMerchant() ? _merchant?.toMap() : _user.toMap();

        await documentReferencer
            .set(data)
            .whenComplete(() => showToast(
                msg: "Success\nVerify email is sent.", backColor: Colors.green))
            .catchError((e) => logger.e(e));
        progressDialog.setMessage(const Text('Verify email is sent.'));
        //* sending verify email
        await userCredential?.user?.sendEmailVerification();
        Future.delayed(const Duration(milliseconds: 200));
        progressDialog.dismiss();

//TOdo:
        AuthHelperFirebase.signOutAndCacheClear();
        Navigator.of(context).pop();
      } else {
        showToast(msg: 'Failed');
      }

      progressDialog.dismiss();
    } on FirebaseAuthException catch (e) {
      progressDialog.dismiss();
      if (e.code == 'email-already-in-use') {
        showToast(msg: 'Email is already in Use');
      } else if (e.code == 'weak-password') {
        showToast(msg: 'Password is weak');
      }
    } catch (e) {
      progressDialog.dismiss();
      logger.i('catch sign up : $e');
      showToast(msg: 'Something went wrong');
    }
  }
}
