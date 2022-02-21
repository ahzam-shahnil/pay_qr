// Flutter imports:
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:pay_qr/config/constants.dart';
import 'package:pay_qr/services/show_toast.dart';

class AuthHelperFirebase {
  String? userUid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  static Logger log = Logger();

  // Create storage
  static const _sharedPref = FlutterSecureStorage();
  // Future<void> addItem(
  //     {required UserDetail userDetail, required String collectionName}) async {
  //   DocumentReference documentReferencer =
  //       _firestore.collection(collectionName).doc(userUid);

  //   await documentReferencer
  //       .set(userDetail)
  //       .whenComplete(() => debugPrint("Notes item added to the database"))
  //       .catchError((e) => debugPrint(e));
  // }

  Stream<DocumentSnapshot<Map<String, dynamic>>> readItems(
      {required String collectionName}) {
    DocumentReference<Map<String, dynamic>> notesItemCollection =
        _firestore.collection(collectionName).doc(userUid);

    return notesItemCollection.snapshots();
  }

  Future<void> updateItem(
      {required String title,
      required String description,
      required String docId,
      required String collectionName}) async {
    DocumentReference documentReferencer =
        _firestore.collection(collectionName).doc(docId);

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
        _firestore.collection(collectionName).doc(docId);
    await documentReferencer
        .delete()
        .whenComplete(() => debugPrint('Item deleted from the database'))
        .catchError((e) => debugPrint(e));
  }

  static String? getCurrentUserUid() {
    // FirebaseAuth auth = FirebaseAuth.instance;
    if (_auth.currentUser != null) {
      debugPrint(_auth.currentUser?.uid);

      return _auth.currentUser?.uid;
    }
    return null;
  }

  static void _clearCache() async {
    await DefaultCacheManager().emptyCache();
    // showToast(
    //     msg: 'Cache Cleared', backColor: Colors.green, textColor: Colors.white);
  }

  static Future<void> signOutAndCacheClear() async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    try {
      if (_auth.currentUser != null) {
        debugPrint(_auth.currentUser?.uid);
        _auth.signOut();
        // Delete value
        await _sharedPref.delete(key: kUserCredSharedPrefKey);
        await _sharedPref.delete(key: kUserTypeSharedPrefKey);
        _clearCache();

// Delete all
        // await _sharedPref.deleteAll();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(msg: 'Email is already in Use');
      } else if (e.code == 'weak-password') {
        showToast(msg: 'Password is weak');
      }
    } catch (e) {
      log.i('catch sign up : $e');
      showToast(msg: 'Something went wrong');
    }
  }

  static User? getCurrentUserDetails() {
    // FirebaseAuth auth = FirebaseAuth.instance;
    try {
      if (_auth.currentUser != null) {
        log.i(_auth.currentUser);
        return _auth.currentUser;
      }
      return null;
    } catch (e) {
      rethrow;
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
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
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
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
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
