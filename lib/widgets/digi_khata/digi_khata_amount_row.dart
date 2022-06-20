// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pay_qr/config/app_constants.dart';
// import 'package:pay_qr/config/controllers.dart';

// import 'reusable_card.dart';

// class DigiKhataAmountRow extends StatelessWidget {
//   const DigiKhataAmountRow({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(14.0),
//       child: Row(
//         children: [
//           Obx(() => Expanded(
//                 child: ReuseableCard(
//                   textColor: Colors.red,
//                   backColor: kScanBackColor,
//                   text: "Maine Lene hain",
//                   title: (amountController.totalPaisayLene.value -
//                               amountController.totalPaisayDene.value) >
//                           0
//                       ? (amountController.totalPaisayLene.value -
//                               amountController.totalPaisayDene.value)
//                           .toStringAsFixed(0)
//                           .replaceAll('-', '')
//                       : '0',
//                   isMaineLene: true,
//                 ),
//               )),
//           const SizedBox(
//             width: 8.0,
//           ),
//           Obx(() => Expanded(
//                 child: ReuseableCard(
//                   backColor: kScanBackColor,
//                   textColor: Colors.green,
//                   text: "Maine Dene hain",
//                   title: (amountController.totalPaisayLene.value -
//                               amountController.totalPaisayDene.value) <
//                           0
//                       ? (amountController.totalPaisayLene.value +
//                               amountController.totalPaisayDene.value)
//                           .toStringAsFixed(0)
//                           .replaceAll('-', '')
//                       : '0',
//                   isMaineLene: false,
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }
