import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/firebase.dart';

class PaymentsController extends GetxController {
  static PaymentsController instance = Get.find();

  getPaymentHistoryStream() {
    try {
      return firestore
          .collection(kUserDb)
          .doc(auth.currentUser?.uid)
          .collection(kPaymentCollection)
          .orderBy('date', descending: true)
          .snapshots();
    } on FirebaseException catch (e) {
      logger.e(e);
      // return null;
    } catch (e) {
      logger.e(e);
      // return null;
    }
  }
}
