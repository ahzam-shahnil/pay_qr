// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/model/payment_model.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';

import '../model/product_model.dart';

class AuthHelperFirebase {
  String? userUid;

  Stream<DocumentSnapshot<Map<String, dynamic>>> readItems(
      {required String collectionName}) {
    DocumentReference<Map<String, dynamic>> notesItemCollection =
        firestore.collection(collectionName).doc(userUid);

    return notesItemCollection.snapshots();
  }

  Future<void> updateItem(
      {required String title,
      required String description,
      required String docId,
      required String collectionName}) async {
    DocumentReference documentReferencer =
        firestore.collection(collectionName).doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => debugPrint("Note item updated in the database"))
        .catchError((e) => debugPrint(e));
  }

  Future<void> deleteItem(
      {required String docId, required String collectionName}) async {
    DocumentReference documentReferencer =
        firestore.collection(collectionName).doc(docId);
    await documentReferencer
        .delete()
        .whenComplete(() => debugPrint('Item deleted from the database'))
        .catchError((e) => debugPrint(e));
  }

  static String? getCurrentUserUid() {
    // FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      debugPrint(auth.currentUser?.uid);
      return auth.currentUser?.uid;
    }
    return null;
  }

  static Future<bool> performPaymentTransaction(
      PaymentModel paymentModel) async {
    bool result = false;
    final senderDocRef = firestore
        .collection(kUserDb)
        .doc(paymentModel.senderId)
        .collection(kProfileCollection)
        .doc(paymentModel.senderId);
    final receiverDocRef = firestore
        .collection(kUserDb)
        .doc(paymentModel.receiverId)
        .collection(kProfileCollection)
        .doc(paymentModel.receiverId);
    final receiverPaymentDocRef = firestore
        .collection(kUserDb)
        .doc(paymentModel.receiverId)
        .collection(kPaymentCollection)
        .doc();
    final senderPaymentDocRef = firestore
        .collection(kUserDb)
        .doc(paymentModel.senderId)
        .collection(kPaymentCollection)
        .doc();

    // final sfDocRef = firestore.collection("cities").doc("SF");
    await firestore.runTransaction((transaction) async {
      //? Getting the sender and receiver snapshot
      final senderSnapshot = await transaction.get(senderDocRef);
      // final senderPaymentSnapshot = await transaction.get(senderDocRef);

      final receiverSnapshot = await transaction.get(receiverDocRef);
      // final receiverPaymentSnapshot = await transaction.get(senderDocRef);

      //? Setting  the sender and receiver balance
      final newSenderBalance =
          senderSnapshot.get("balance") - paymentModel.amount;

      final newReceiverBalance =
          receiverSnapshot.get("balance") + paymentModel.amount;

      //? Updating the sender and receiver Data
      transaction
          .update(senderDocRef, {"balance": newSenderBalance, "cart": []});
      transaction.update(receiverDocRef, {"balance": newReceiverBalance});
      transaction.set(senderPaymentDocRef, paymentModel.toMap());
      transaction.set(receiverPaymentDocRef, paymentModel.toMap());
    }).then(
      (value) {
        logger.d("DocumentSnapshot successfully updated!");
        result = true;
      },
      onError: (e) {
        logger.e("Error updating document $e");
      },
    );
    return result;
  }

  // static void _clearCache() async {
  //   await DefaultCacheManager().emptyCache();
  // }

  static Future<void> signOutAndCacheClear() async {
    logger.d(auth.currentUser);
    try {
      if (auth.currentUser != null) {
        await auth.signOut();
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
    }
  }

  static User? getCurrentFireBaseUser() {
    try {
      if (auth.currentUser != null) {
        return auth.currentUser;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<ProductModel>?> fetchProducts(String uid) async {
    var data = await firestore
        .collection(kUserDb)
        .doc(uid)
        .collection(kProductCollection)
        .orderBy('title', descending: true)
        .get();
    try {
      return List.from(data.docs.map((e) => ProductModel.fromSnapshot(e)));
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  void deleteFirebaseUser(String email, String password, String collectionName,
      String docId) async {
    try {
      UserCredential? userCredentials = await logInUser(email, password);
      if (userCredentials?.user != null) {
        await deleteItem(docId: docId, collectionName: collectionName);
        await userCredentials?.user?.delete();
        Fluttertoast.showToast(
            msg: 'Deleted Record Sucessfully', backgroundColor: kBtnColor);
      } else {
        Fluttertoast.showToast(
            msg: 'No Record deleted', backgroundColor: kBtnColor);
      }
      // await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        debugPrint(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  static Future<UserCredential?> logInUser(
      String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
      rethrow;
    }
  }

  static Future<UserCredential?> signUp(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        debugPrint('Email is already in Use');
      } else if (e.code == 'weak-password') {
        debugPrint('Password is weak');
      }

      rethrow;
    }
  }

  dynamic authenticaTeUser(String email, String password) async {
// Create a credential
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);

// Reauthenticate
    await FirebaseAuth.instance.currentUser!
        .reauthenticateWithCredential(credential);
  }
}
