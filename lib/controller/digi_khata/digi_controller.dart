import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/model/digi_khata/cash_in_model.dart';
import 'package:pay_qr/model/digi_khata/customer.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../view/main_views/digi_khata/add_customer/contact_view.dart';

class DigiController extends GetxController {
  static DigiController instance = Get.find();
  late CollectionReference _mainCollection;
  var customer = <CustomerModel>[].obs;
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
          .snapshots();
    } on FirebaseException {
      showToast(
        msg: 'Error',
      );
    }
  }

  saveCashInOutKhata(CashModel cash) async {
    _mainCollection = _getCashInOutCollectionRef();
    try {
      await _mainCollection
          .doc(AuthHelperFirebase.getCurrentUserUid())
          .collection(kCashInOutCollection)
          .add(cash.toMap());
      showToast(msg: 'Success', backColor: Colors.green);
    } on FirebaseException {
      showToast(
        msg: 'Error',
      );
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

      showToast(
          msg: "Success", backColor: Colors.white, textColor: kPrimaryColor);

      return true;
    } on FirebaseException {
      progressDialog.dismiss();

      showToast(
        msg: 'Something Went Wrong',
      );
      return false;
    } catch (e) {
      progressDialog.dismiss();

      showToast(
        msg: 'Something Went Wrong',
      );
      return false;
    }
  }

  getCustomerSpecificRecord(String id) async {
    _mainCollection = _getCollectionRef();
    // logger.d(_mainCollection.doc(id).snapshots());
    var data = await _mainCollection.doc(id).get();
    try {
      return CustomerModel.fromSnapshot(data);
    } catch (e) {
      logger.e(e);
      return null;
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
      showToast(msg: "Success", backColor: Colors.green);
      return true;
    } on FirebaseException {
      showToast(
        msg: "Error",
      );
      return false;
    } catch (e) {
      showToast(
        msg: "Error",
      );
      return false;
    }
  }

  _getCashInOutCollectionRef() {
    final CollectionReference tempRef;
    if (loginController.isMerchant()) {
      tempRef = firestore.collection(kMerchantDb);
    } else {
      tempRef = firestore.collection(kUserDb);
    }
    return tempRef;
  }

  _getCollectionRef() {
    final CollectionReference tempRef;
    if (loginController.isMerchant()) {
      tempRef = firestore
          .collection(kMerchantDb)
          .doc(AuthHelperFirebase.getCurrentUserUid())
          .collection(kDigiCollection);
    } else {
      tempRef = firestore
          .collection(kUserDb)
          .doc(AuthHelperFirebase.getCurrentUserUid())
          .collection(kDigiCollection);
    }
    return tempRef;
  }
}
