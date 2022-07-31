// Dart imports:
import 'dart:async';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/controller/base_controller.dart';
import 'package:pay_qr/model/product_model.dart';
import 'package:pay_qr/model/qr_model.dart';
import 'package:pay_qr/utils/auth_helper_firebase.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:uuid/uuid.dart';

class ProductAddController extends GetxController with BaseController {
  static ProductAddController instance = Get.find();
  var data = ''.obs;
  var isVisible = false.obs;
  // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  // Logger log = Logger();
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
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
        documentReferencer = firestore
            .collection(kUserDb)
            .doc(uid)
            .collection(kProductCollection)
            .doc();
        //*Saving Qr Details to Qr image
        var shopName = userController.userModel.value.shopName;
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
        logger.i(product);
        await documentReferencer
            .set(product.toMap())
            .whenComplete(() => logger.i("Item item added to the database"))
            .catchError((e) => logger.e(e));

        data.value = qr.toJson();
      } else {
        showSnackBar(msg: 'Something went wrong');
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
}
