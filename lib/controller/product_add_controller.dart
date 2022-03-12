// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/controller/base_controller.dart';
import 'package:pay_qr/controller/profile_controller.dart';
import 'package:pay_qr/model/product_model.dart';
import 'package:pay_qr/model/qr_model.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';

class ProductAddController extends GetxController with BaseController {
  static ProductAddController instance = Get.find();
  var data = ''.obs;
  // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Logger log = Logger();
  String? uid;

  dynamic saveProduct(ProductModel product) async {
    await _uploadProduct(product);
  }

  Future<void> _uploadProduct(ProductModel product) async {
    uid = AuthHelperFirebase.getCurrentUserUid();
    DocumentReference? documentReferencer;
    try {
      if (uid != null) {
        //? check that product is added as seaprate not overlapped on one
        documentReferencer = firebaseFirestore
            .collection(kMerchantDb)
            .doc(uid)
            .collection(kProductCollection)
            .doc();
        //*Saving Qr Details to Qr image
        var shopName = Get.find<ProfileController>().currentUser.value.shopName;
        // log.i(shopName);
        var qr = QrModel(
          uid: uid!,
          shopName: shopName,
          productId: documentReferencer.id,
          productName: product.title,
        );
        // log.i(qr);
        //* updating product details
        var productId = const Uuid();
        product = product.copyWith(
          qr: qr,
          id: productId.v4(),
          numberOfViews: 0,
        );
        log.i(product);
        await documentReferencer
            .set(product.toMap())
            .whenComplete(() => log.i("Item item added to the database"))
            .catchError((e) => log.e(e));

        data.value = qr.toJson();

        showToast(msg: 'Success', backColor: Colors.green);
      } else {
        showToast(msg: 'Something went wrong');
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

  // Future<void> _saveQrData(QrModel qrModel) async {
  //   String collectionRef = 'qr';

  //   try {
  //     await _firestore
  //         .collection(collectionRef)
  //         .doc(qrModel.uid)
  //         .set({"docId": itemDocId, "collectionRef": shopDbRef}).timeout(
  //             const Duration(seconds: 10));

  //     data.value = "{'docId': itemDocId, 'collectionRef': shopDbRef}";
  //   } on SocketException {
  //     throw FetchDataException('No Internet connection');
  //   } on TimeoutException {
  //     throw ApiNotRespondingException('API not responded in time');
  //   }
  // }
}
