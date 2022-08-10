import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/model/customer.dart';
import 'package:pay_qr/model/digi_khata/cash_model.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../view/main_views/digi_khata/add_customer/contact_view.dart';

class DigiController extends GetxController {
  static DigiController instance = Get.find();
  late CollectionReference _mainCollection;
  var customer =
      CustomerModel(id: '', name: '', phoneNo: '', cashRecords: []).obs;
  getPermissionAndGotoContactView() async {
    if (await Permission.contacts.request().isGranted) {
      Get.to(
        () => const ContactView(),
      );
    }
  }

  getRecordStream() {
    _mainCollection = _getCollectionRef();

    return _mainCollection.snapshots();
  }

  getCashBookStream() {
    _mainCollection = _getCashInOutCollectionRef();
    try {
      return _mainCollection
          .doc(AuthHelperFirebase.getCurrentUserUid())
          .collection(kCashInOutCollection)
          .orderBy('date', descending: true)
          // .startAfter(lastDoc)
          .snapshots();
    } on FirebaseException catch (e) {
      showSnackBar(
        msg: 'Error',
      );
      logger.e(e);
    }
  }

  Future<bool> saveCashInOutKhata({required CashModel record}) async {
    _mainCollection = _getCashInOutCollectionRef();
    DocumentReference? doc;
    try {
      doc = _mainCollection
          .doc(AuthHelperFirebase.getCurrentUserUid())
          .collection(kCashInOutCollection)
          .doc();
      //*setting doc id here
      record = record.copyWith(id: doc.id);
      await doc.set(
        record.toMap(),
      );
      showSnackBar(
        msg: 'Success',
        backColor: Colors.green,
        iconData: Icons.done_rounded,
      );
      return true;
    } on FirebaseException {
      showSnackBar(
        msg: 'Error',
      );
      return false;
    } catch (e) {
      showSnackBar(
        msg: 'Error',
      );
      return false;
    }
  }

  Future<bool> updateCashInOutKhata({required CashModel record}) async {
    _mainCollection = _getCashInOutCollectionRef();
    DocumentReference docRef;
    try {
      docRef = _mainCollection
          .doc(AuthHelperFirebase.getCurrentUserUid())
          .collection(kCashInOutCollection)
          .doc(record.id);
      // .update(record.toMap());
      await docRef.set(record.toMap());
      showSnackBar(
        msg: 'Success',
        backColor: Colors.green,
        iconData: Icons.done_rounded,
      );
      return true;
    } on FirebaseException {
      showSnackBar(
        msg: 'Error',
      );
      return false;
    } catch (e) {
      showSnackBar(
        msg: 'Error',
      );
      return false;
    }
  }

  Future<bool> deleteCashInOutKhata({required String id}) async {
    _mainCollection = _getCashInOutCollectionRef();

    try {
      await _mainCollection
          .doc(AuthHelperFirebase.getCurrentUserUid())
          .collection(kCashInOutCollection)
          .doc(id)
          .delete();
      // .update(record.toMap());
      showSnackBar(
        msg: 'Success',
        backColor: Colors.green,
        iconData: Icons.done_rounded,
      );
      return true;
    } on FirebaseException {
      showSnackBar(
        msg: 'Error',
      );
      return false;
    } catch (e) {
      showSnackBar(
        msg: 'Error',
      );
      return false;
    }
  }

  Future<bool> removeCustomerRecord({required CustomerModel customer}) async {
    logger.d(customer);
    _mainCollection = await _getCollectionRef();
    try {
      // logger.d(record);
      await _mainCollection.doc(customer.id).set(customer.toMap());
      // showSnackBar(
      //   msg: "Success",
      //   backColor: Colors.green,
      //   iconData: Icons.done_rounded,
      // );
      return true;
    } on FirebaseException {
      // showSnackBar(
      //   msg: "Error",
      // );
      return false;
    } catch (e) {
      // Get.snackbar("Error", "Cannot remove this");
      // debugPrint(e);
      logger.e(e);
      return false;
    }
  }

  Future<bool> updateCustomerRecord(
      {required String id, required CashModel record}) async {
    logger.d(id);
    _mainCollection = await _getCollectionRef();
    try {
      _mainCollection.doc(id).update({
        kCashRecordsField: FieldValue.arrayUnion([record.toMap()])
      });
      // showSnackBar(
      //   msg: "Success",
      //   backColor: Colors.green,
      //   iconData: Icons.done_rounded,
      // );
      return true;
    } on FirebaseException {
      // showSnackBar(
      //   msg: "Error",
      // );
      return false;
    } catch (e) {
      // showSnackBar(
      //   msg: "Error",
      // );
      return false;
    }
  }

  Future<bool> saveCustomer(
      CustomerModel customer, BuildContext context) async {
    var progressDialog = getProgressDialog(
        context: context, msg: 'Please wait', title: 'Saving Customer');

    progressDialog.show();
    //? to update customer with id
    _mainCollection = _getCollectionRef();

    try {
      await _mainCollection.doc(customer.id).set(customer.toMap());
      progressDialog.dismiss();

      // showSnackBar(
      //   msg: "Success",
      //   backColor: Colors.white,
      //   textColor: kPrimaryColor,
      //   iconData: Icons.done_rounded,
      // );

      return true;
    } on FirebaseException {
      progressDialog.dismiss();

      // showSnackBar(
      //   msg: 'Something Went Wrong',
      // );
      return false;
    } catch (e) {
      progressDialog.dismiss();

      // showSnackBar(
      //   msg: 'Something Went Wrong',
      // );
      return false;
    }
  }

  getCustomerSpecificRecord(String id) async {
    _mainCollection = _getCollectionRef();
    // logger.d(_mainCollection.doc(id).snapshots());
    var data = await _mainCollection.doc(id).get();
    // Stream<DocumentSnapshot> stream = _mainCollection.doc(id).snapshots();
    // stream.listen((snapshot) {
    //   var data = snapshot;

    //   customer.value = CustomerModel.fromSnapshot(data);
    // });

    try {
      return CustomerModel.fromSnapshot(data);
    } catch (e) {
      logger.e(e);
      return null;
    }
  }

  _getCashInOutCollectionRef() {
    final CollectionReference tempRef;
    // if (loginController.isMerchant()) {
    //   tempRef = firestore.collection(kMerchantDb);
    // } else {
    //   tempRef = firestore.collection(kUserDb);
    // }
    tempRef = firestore.collection(kUserDb);
    return tempRef;
  }

  _getCollectionRef() {
    final CollectionReference tempRef;
    // if (loginController.isMerchant()) {
    //   tempRef = firestore
    //       .collection(kMerchantDb)
    //       .doc(AuthHelperFirebase.getCurrentUserUid())
    //       .collection(kDigiCollection);
    // } else {
    tempRef = firestore
        .collection(kUserDb)
        .doc(AuthHelperFirebase.getCurrentUserUid())
        .collection(kDigiCollection);
    // }
    return tempRef;
  }
}
