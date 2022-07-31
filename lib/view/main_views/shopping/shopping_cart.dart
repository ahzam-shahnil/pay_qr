// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_qr/config/app_constants.dart';
// Project imports:
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/payment_model.dart';
import 'package:pay_qr/model/qr_model.dart';
import 'package:pay_qr/utils/toast_dialogs.dart';
import 'package:pay_qr/view/main_views/shopping/widgets/cart_item_widget.dart';
import 'package:pay_qr/widgets/shared/custom_btn.dart';
import 'package:pay_qr/widgets/shared/custom_text.dart';

class ShoppingCartWidget extends StatelessWidget {
  const ShoppingCartWidget({Key? key, required this.qrModel}) : super(key: key);
  final QrModel qrModel;
  Future<bool> sendMoney() async {
    if (cartController.totalCartPrice.value <= 0) {
      showSnackBar(msg: 'Invalid Amount');
      return false;
    }
    if (cartController.totalCartPrice.value >
        userController.userModel.value.balance) {
      showSnackBar(msg: 'Insufficient Balance in Account');
      return false;
    }
    var paymentModel = PaymentModel(
      amount: cartController.totalCartPrice.value,
      date: DateTime.now().toString(),
      isSent: true,
      paymentId: uid.v4(),
      receiver: qrModel.shopName!,
      receiverId: qrModel.uid,
      sender: userController.userModel.value.fullName!,
      senderId: userController.userModel.value.uid!,
    );
    bool result = await profileController.updateProfileBalance(paymentModel);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: CustomText(
                text: "Shopping Cart",
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Obx(() => Column(
                  children: userController.userModel.value.cart
                          ?.map((cartItem) => CartItemWidget(
                                cartItem: cartItem,
                              ))
                          .toList() ??
                      [],
                )),
          ],
        ),
        Obx(
          () => Positioned(
            bottom: 30,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(8),
              child: CustomButton(
                text:
                    "Pay Rs ${cartController.totalCartPrice.value.toString()}",
                onTap: () async {
                  if (cartController.totalCartPrice.value > 0) {
                    var progressDialog = getProgressDialog(
                        context: context,
                        msg: 'Please Wait',
                        title: 'Sending Money');
                    progressDialog.show();
                    bool result = await sendMoney();
                    progressDialog.dismiss();
                    if (result) {
                      showSnackBar(
                        msg: "Success",
                        iconData: Icons.done_rounded,
                      );
                      // cartController.
                    } else {
                      showSnackBar(msg: "Failure");
                    }
                  } else {
                    showSnackBar(msg: 'Cart is Empty');
                    return;
                  }
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
