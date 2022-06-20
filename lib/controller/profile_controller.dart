// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/controller/login_controller.dart';
import 'package:pay_qr/model/user_model.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import '../config/app_constants.dart';

class ProfileController extends GetxController {
  static ProfileController instance = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  var currentUser = UserModel(
      uid: '',
      fullName: '',
      email: '',
      password: '',
      isMerchant: false,
      cart: []).obs;
  // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final loginController = Get.find<LoginController>();
  final isLoading = true.obs;
  // Create storage
  final storage = const FlutterSecureStorage();
  Logger log = Logger();
  // @override
  // void onInit() {
  //   super.onInit();
  //   getProfile();
  // }

  showLoading() {
    isLoading.value = true;
  }

  hideLoading() {
    isLoading.value = false;
  }

  Future<void> updateProfile(UserModel userUpdate, BuildContext context) async {
    try {
      CollectionReference mainCollection;

      //* Checking User to store Data
      if (currentUser.value.isMerchant!) {
        mainCollection = firestore.collection(kMerchantDb);
      } else {
        mainCollection = firestore.collection(kUserDb);
      }

//? setting account password
      await AuthHelperFirebase.getCurrentUserDetails()!
          .updatePhotoURL(userUpdate.imageUrl);
      await AuthHelperFirebase.getCurrentUserDetails()!
          .updatePassword(userUpdate.password!);
      DocumentReference documentReferencer = mainCollection
          .doc(userUpdate.uid)
          .collection(kProfileCollection)
          .doc(userUpdate.uid);

      await documentReferencer
          .set(userUpdate.toMap())
          .whenComplete(
              () => showToast(msg: "Profile Updated", backColor: Colors.green))
          .catchError((e) => throw (e));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(msg: 'Email is already in Use');
      } else if (e.code == 'weak-password') {
        showToast(msg: 'Password is weak');
      }
    } catch (e) {
      log.i('catch sign up : $e');
      showToast(msg: 'Something went wrong');
      rethrow;
    }
  }

  Future<QuerySnapshot<Object?>?> getProfile() async {
    showLoading();
    try {
      final CollectionReference? mainCollection = getProfileCollection();
      if (mainCollection != null) {
        var data = await mainCollection.get();

        // await collection.then((QuerySnapshot querySnapshot) => {
        //       for (final document in querySnapshot.docs) {document.data()}
        //     });

        var users = data.docs.map((e) => UserModel.fromSnapshot(e));
        // log.i(users);
        // users.isEmpty;
        for (var item in users) {
          currentUser.value = item;
          log.i("Current user is $currentUser");
        }
        hideLoading();
        return data;
      }
    } on FirebaseAuthException catch (e) {
      // progressDialog.dismiss();
      hideLoading();
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
      // progressDialog.dismiss();
      hideLoading();
      showToast(
        msg: 'Something went wrong',
      );
      debugPrint('e : $e');
    }
    return null;
  }

  CollectionReference? getProfileCollection() {
    try {
      User? user = AuthHelperFirebase.getCurrentUserDetails();
      final CollectionReference mainCollection;
      if (user != null) {
        //* Checking User to store Data
        if (loginController.isMerchant()) {
          mainCollection = firestore
              .collection(kMerchantDb)
              .doc(user.uid)
              .collection(kProfileCollection);
        } else {
          mainCollection = firestore
              .collection(kUserDb)
              .doc(user.uid)
              .collection(kProfileCollection);
        }
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
