// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/model/user_model.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/view/main_views/home/nav_home.dart';

import '../view/main_views/auth/login_screen.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();
  late CollectionReference _mainCollection;
  Rx<UserModel> userModel = UserModel(
    cart: [],
    email: '',
    fullName: '',
    imageUrl: '',
    isMerchant: false,
    password: '',
    shopName: '',
    uid: '',
    balance: 0,
  ).obs;

  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);

    firebaseUser.bindStream(auth.userChanges());
    // userModel.bindStream(listenToUser());
    setInitialScreen(true);
  }

  setInitialScreen(bool doWait) async {
    if (doWait) {
      await Future.delayed(const Duration(seconds: 3));
    }
    if (auth.currentUser == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      userModel.bindStream(listenToUser());
      Get.offAll(() => const NavHomeScreen());
    }
  }

  bindUserStream() {
    userModel.bindStream(listenToUser());
  }

  // void signIn() async {
  //   try {
  //     showLoading();
  //     await auth
  //         .signInWithEmailAndPassword(
  //             email: email.text.trim(), password: password.text.trim())
  //         .then((result) {
  //       _clearControllers();
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     Get.snackbar("Sign In Failed", "Try again");
  //   }
  // }

  // void signUp() async {
  //   showLoading();
  //   try {
  //     await auth
  //         .createUserWithEmailAndPassword(
  //             email: email.text.trim(), password: password.text.trim())
  //         .then((result) {
  //       String _userId = result.user!.uid;
  //       _addUserToFirestore(_userId);
  //       _clearControllers();
  //     });
  //   } catch (e) {
  //     debugPrint(e.toString());
  //     Get.snackbar("Sign In Failed", "Try again");
  //   }
  // }

  // void signOut() async {
  //   auth.signOut();
  // }

  // _addUserToFirestore(String userId) {
  //   firebaseFirestore.collection(usersCollection).doc(userId).set({
  //     "name": name.text.trim(),
  //     "id": userId,
  //     "email": email.text.trim(),
  //     "cart": []
  //   });
  // }

  // _clearControllers() {
  //   name.clear();
  //   email.clear();
  //   password.clear();
  // }

  updateUserData(Map<String, dynamic> data) async {
    //* Checking User to store Data
    // if (loginController.isMerchant()) {
    //   _mainCollection = firestore.collection(kMerchantDb);
    // } else {
    //   _mainCollection = firestore.collection(kUserDb);
    // }

    _mainCollection = firestore.collection(kUserDb);
    logger.i("UPDATED");
    await _mainCollection
        .doc(AuthHelperFirebase.getCurrentUserUid())
        .collection(kProfileCollection)
        .doc(AuthHelperFirebase.getCurrentUserUid())
        .update(data);
  }

  Stream<UserModel> listenToUser() {
    _mainCollection = firestore.collection(kUserDb);

    return _mainCollection
        .doc(AuthHelperFirebase.getCurrentUserUid())
        .collection(kProfileCollection)
        .doc(AuthHelperFirebase.getCurrentUserUid())
        .snapshots()
        .map((snapshot) => UserModel.fromSnapshot(snapshot));
  }
}
