import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/config/firebase.dart';
import 'package:pay_qr/utils/show_loading.dart';
import 'package:pay_qr/view/main_views/payments/payment_history_screen.dart';
import 'package:pay_qr/widgets/shared/custom_text.dart';
import 'package:uuid/uuid.dart';

import '../../model/shop_model/payments.dart';

class PaymentsController extends GetxController {
  static PaymentsController instance = Get.find();
  String collection = "payments";
  String url =
      'https://us-central1-sneex-cbc6a.cloudfunctions.net/createPaymentIntent';
  List<PaymentsModel> payments = [];

  Future<void> createPaymentMethod() async {
    // StripePayment.setStripeAccount(null);
    //step 1: add card
    final paymentMethod = await Stripe.instance
        .createPaymentMethod(const PaymentMethodParams.card());
    // PaymentMethod paymentMethod = PaymentMethod(card: null);
    // paymentMethod = await StripePayment.paymentRequestWithCardForm(
    //   CardFormPaymentRequest(),
    // ).then((PaymentMethod paymentMethod) {
    //   return paymentMethod;
    // }).catchError((e) {
    //   print('Error Card: ${e.toString()}');
    // });

    // paymentMethod != null
    //     ? processPaymentAsDirectCharge(paymentMethod)
    //     : _showPaymentFailedAlert();
    // dismissLoadingWidget();
  }

  Future<void> processPaymentAsDirectCharge(PaymentMethod paymentMethod) async {
    showLoading();

    int amount =
        (double.parse(cartController.totalCartPrice.value.toStringAsFixed(2)) *
                100)
            .toInt();
    //step 2: request to create PaymentIntent, attempt to confirm the payment & return PaymentIntent
    final response = await Dio()
        .post('$url?amount=$amount&currency=USD&pm_id=${paymentMethod.id}');
    print('Now i decode');
    if (response.data != null && response.data != 'error') {
      final paymentIntentX = response.data;
      final status = paymentIntentX['paymentIntent']['status'];
      if (status == 'succeeded') {
        // StripePayment.completeNativePayRequest();
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
        userController.updateUserData({"cart": []});
        Get.snackbar("Success", "Payment succeeded");
      } else {
        _addToCollection(paymentStatus: status, paymentId: paymentMethod.id);
      }
    } else {
      //case A
      // Stripe.cancelNativePayRequest();
      _showPaymentFailedAlert();
    }
  }

  void _showPaymentFailedAlert() {
    Get.defaultDialog(
        content: const CustomText(
          text: "Payment failed, try another card",
        ),
        actions: [
          GestureDetector(
              onTap: () {
                Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Okay",
                ),
              ))
        ]);
  }

  _addToCollection({required String paymentStatus, required String paymentId}) {
    String id = const Uuid().v1();
    firestore.collection(collection).doc(id).set({
      "id": id,
      "clientId": userController.userModel.value.uid,
      "status": paymentStatus,
      "paymentId": paymentId,
      "cart": userController.userModel.value.cartItemsToJson(),
      "amount": cartController.totalCartPrice.value.toStringAsFixed(2),
      "createdAt": DateTime.now().microsecondsSinceEpoch,
    });
  }

  getPaymentHistory() {
    showLoading();
    payments.clear();
    firestore
        .collection(collection)
        .where("clientId", isEqualTo: userController.userModel.value.uid)
        .get()
        .then((snapshot) {
      for (var doc in snapshot.docs) {
        PaymentsModel payment = PaymentsModel.fromMap(doc.data());
        payments.add(payment);
      }

      logger.i("length ${payments.length}");
      dismissLoadingWidget();
      Get.to(() => const PaymentHistoryScreen());
    });
  }
}
