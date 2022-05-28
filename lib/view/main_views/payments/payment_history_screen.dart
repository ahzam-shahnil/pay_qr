import 'package:flutter/material.dart';

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
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Payment History",
        ),
      ),
      body: ListView(
        children: const [
          Text("Add Payment Method")
          //TODO: Add payment controller list
          // Column(
          //   children: paymentsController.payments
          //       .map((payment) => PaymentWidget(
          //             paymentsModel: payment,
          //           ))
          //       .toList(),
          // )
        ],
      ),
    );
  }
}
