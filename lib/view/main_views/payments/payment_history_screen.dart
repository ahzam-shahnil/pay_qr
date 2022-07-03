// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pay_qr/config/controllers.dart';
// import 'package:pay_qr/view/main_views/payments/widgets/payment_widget.dart';

// class PaymentHistoryScreen extends StatelessWidget {
//   const PaymentHistoryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             icon: const Icon(Icons.close),
//             onPressed: () {
//               Navigator.pop(context);
//             }),
//         backgroundColor: Colors.grey.withOpacity(.1),
//         iconTheme: const IconThemeData(color: Colors.white),
//         centerTitle: true,
//         elevation: 0,
//         title: const Text(
//           "Payment History",
//         ),
//       ),
//       body: ListView(
//         children: [
//           Obx(() => Column(
//                 children: paymentsController.payments
//                     .map((payment) => PaymentWidget(
//                           paymentsModel: payment,
//                         ))
//                     .toList(),
//               ))
//         ],
//       ),
//     );
//   }
// }
