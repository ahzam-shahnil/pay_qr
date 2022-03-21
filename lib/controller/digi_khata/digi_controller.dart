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

class DigiController extends GetxController {
  static DigiController instance = Get.find();
  late CollectionReference _mainCollection;
  var customer = <CustomerModel>[].obs;
  // var totalLiye = 0.0.obs;
  // var totalDiye = 0.0.obs;
  // var customerName = ''.obs;
  // var phone = ''.obs;
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

  saveCustomer(CustomerModel customer) async {
    //? to update customer with id
    // customer = customer.copyWith(id: id);

    _mainCollection = _getCollectionRef();

    try {
      await _mainCollection.doc(customer.id).set(customer.toMap());
      showToast(msg: "Added Record", backColor: Colors.green);
    } on FirebaseException {
      showToast(
        msg: 'Error',
      );
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

  updateCustomerRecord({required String id, required CashModel record}) async {
    logger.d(id);
    _mainCollection = await _getCollectionRef();
    try {
      _mainCollection.doc(id).update({
        kCashRecordsField: FieldValue.arrayUnion([record.toMap()])
      });
      showToast(msg: "Added Record", backColor: Colors.green);
    } on FirebaseException {
      showToast(
        msg: "Error",
      );
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
