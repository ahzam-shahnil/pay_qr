import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/payment_model.dart';
import 'package:pay_qr/utils/utility.dart';
import 'package:pay_qr/view/main_views/payments/widgets/payment_histoty_info_screen.dart';

class PaymentWidget extends StatelessWidget {
  final PaymentModel paymentsModel;

  const PaymentWidget({Key? key, required this.paymentsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Obx(() => ListTile(
            isThreeLine: true,
            onTap: () => Get.to(
                () => PaymentHistoryInfoScreen(paymentsModel: paymentsModel)),
            leading: CircleAvatar(
              backgroundColor:
                  paymentsModel.senderId == userController.userModel.value.uid
                      ? kPrimaryColor.withOpacity(0.3)
                      : kTealColor.withOpacity(0.3),
              child: Icon(
                paymentsModel.receiverId == userController.userModel.value.uid
                    ? LineIcons.arrowDown
                    : LineIcons.arrowUp,
                color:
                    paymentsModel.senderId == userController.userModel.value.uid
                        ? kPrimaryColor
                        : kTealColor,
              ),
            ),
            title: Text(
                '${paymentsModel.sender}\t- Ref:${paymentsModel.paymentId}',
                overflow: TextOverflow.ellipsis,
                maxLines: 2),
            subtitle: Text(
              Utility.getFormattedTime(DateTime.parse(paymentsModel.date)),
            ),
            trailing: Text(
              '${paymentsModel.senderId == userController.userModel.value.uid ? '-' : '+'} ${paymentsModel.amount}',
              style: Get.textTheme.bodyLarge?.copyWith(
                color:
                    paymentsModel.senderId == userController.userModel.value.uid
                        ? kPrimaryColor
                        : kTealColor,
              ),
            ),
          )),
    );
  }
}
