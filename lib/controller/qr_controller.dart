// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

// Project imports:
import 'package:pay_qr/config/app_exceptions.dart';
import 'package:pay_qr/controller/base_controller.dart';
import 'package:pay_qr/model/product.dart';

class QrController extends GetxController with BaseController {
  var data = ''.obs;

  Logger log = Logger();
  dynamic generateQr(Product product) async {
    showLoading('Generating Qr');
    await _saveProductData(product);
    hideLoading();
    // print(response);
  }

  Future<void> _saveProductData(Product product) async {
    String shopDbCollectionRef = 'products';
    String docId =
        FirebaseFirestore.instance.collection(shopDbCollectionRef).doc().id;
    log.i(docId);

    await FirebaseFirestore.instance
        .collection(shopDbCollectionRef)
        .doc(docId)
        .set(product.toJson());
    await _saveQrData(docId, shopDbCollectionRef).catchError(handleError);
  }

  Future<void> _saveQrData(String itemDocId, String shopDbRef) async {
    String collectionRef = 'qr';

    try {
      await FirebaseFirestore.instance
          .collection(collectionRef)
          .doc(itemDocId)
          .set({"docId": itemDocId, "collectionRef": shopDbRef}).timeout(
              const Duration(seconds: 10));

      data.value = "{'docId': itemDocId, 'collectionRef': shopDbRef}";
    } on SocketException {
      throw FetchDataException('No Internet connection');
    } on TimeoutException {
      throw ApiNotRespondingException('API not responded in time');
    }
  }
}
