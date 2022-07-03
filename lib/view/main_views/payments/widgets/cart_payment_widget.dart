import 'package:flutter/material.dart';
import 'package:pay_qr/model/shop_model/payments.dart';
import 'package:pay_qr/widgets/shared/custom_text.dart';
import 'package:timeago/timeago.dart' as timeago;

class CartPaymentWidget extends StatelessWidget {
  final CartPaymentsModel paymentsModel;

  const CartPaymentWidget({Key? key, required this.paymentsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(.5), blurRadius: 15)
          ]),
      child: Wrap(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomText(
                  text: "ITEMS:",
                  color: Colors.grey,
                ),
              ),
              CustomText(
                text: paymentsModel.cart.length.toString(),
                color: Colors.black,
                weight: FontWeight.bold,
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: "Rs ${paymentsModel.amount}",
                  color: Colors.black,
                  weight: FontWeight.bold,
                  size: 18,
                ),
              ),
              const SizedBox(
                width: 5,
              )
            ],
          ),
          const Divider(),
          Column(
              children: paymentsModel.cart
                  .map((item) => ListTile(
                        title: CustomText(
                          text: item['name'],
                        ),
                        trailing: CustomText(
                          text: "Rs ${item['cost']}",
                        ),
                      ))
                  .toList()),
          const Divider(),
          ListTile(
            title: CustomText(
              text: _returnDate(),
              color: Colors.grey,
            ),
            trailing: CustomText(
              text: paymentsModel.status,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }

  String _returnDate() {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(paymentsModel.createdAt);
    return timeago.format(date, locale: 'fr');
  }
}
