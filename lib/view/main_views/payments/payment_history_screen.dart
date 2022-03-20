import 'package:flutter/material.dart';
import 'package:pay_qr/config/controllers.dart';

import 'widgets/payment_widget.dart';

class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Colors.grey.withOpacity(.1),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Payment History",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: paymentsController.payments
                .map((payment) => PaymentWidget(
                      paymentsModel: payment,
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
