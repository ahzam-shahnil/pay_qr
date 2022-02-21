// Dart imports:
import 'dart:async';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:pay_qr/config/constants.dart';
import 'package:pay_qr/controller/base_controller.dart';
import 'package:pay_qr/controller/profile_controller.dart';
import 'package:pay_qr/model/product.dart';
import 'package:pay_qr/model/qr_model.dart';
import 'package:pay_qr/services/auth_helper_firebase.dart';
import 'package:pay_qr/services/show_toast.dart';

class ProductController extends GetxController with BaseController {
  var data = ''.obs;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Logger log = Logger();
  String? uid;

  dynamic saveProduct(Product product) async {
    await _uploadProduct(product);
  }

  Future<void> _uploadProduct(Product product) async {
    uid = AuthHelperFirebase.getCurrentUserUid();
    DocumentReference? documentReferencer;
    try {
      if (uid != null) {
        //? check that product is added as seaprate not overlapped on one
        documentReferencer = _firestore
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
        product = product.copyWith(
          qr: qr,
          numberOfViews: 0,
        );
        log.i(product);
        await documentReferencer
            .set(product.toMap())
            .whenComplete(() => log.i("Item item added to the database"))
            .catchError((e) => log.e(e));

        data.value = qr.toMap().toString();

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
