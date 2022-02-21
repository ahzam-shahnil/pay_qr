import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pay_qr/controller/login_controller.dart';
import 'package:pay_qr/services/auth_helper_firebase.dart';

import '../config/constants.dart';
import '../model/user_model.dart';
import '../services/show_toast.dart';

class SignUpController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // FirebaseAuth auth = FirebaseAuth.instance;
  final loginController = Get.find<LoginController>();
  // Create storage
  final storage = const FlutterSecureStorage();
  final Logger log = Logger();

  Future<void> signUpUser({
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
      log.i('before database');

      if (userCredential?.user != null) {
        final CollectionReference _mainCollection;
        UserModel? _user;
        // Merchant? _merchant;
        String? uid = userCredential?.user!.uid;

        //* Checking User to store Data
        if (loginController.isMerchant()) {
          _mainCollection = _firestore.collection(kMerchantDb);
          _user = UserModel(
            fullName: fullName,
            email: email,
            password: password,
            uid: uid!,
            isMerchant: true,
            shopName: shopName,
          );
        } else {
          _mainCollection = _firestore.collection(kUserDb);
          //?Make models for Shop keeper and user sign up
          _user = UserModel(
            fullName: fullName,
            email: email,
            password: password,
            uid: uid!,
            isMerchant: false,
          );
        }

        log.i('after database');
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
            .catchError((e) => log.e(e));
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
      log.i('catch sign up : $e');
      showToast(msg: 'Something went wrong');
    }
  }
}
