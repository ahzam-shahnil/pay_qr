// // Flutter imports:
// import 'package:flutter/material.dart';

// // Project imports:
// import 'custom_text.dart';

// class ProductListTile extends StatelessWidget {
//   const ProductListTile({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Image.asset(
//               'assets/images/scan_intro.png',
//               width: 140,
//             ),
//           ),
//           Wrap(
//             direction: Axis.vertical,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Row(
//                   children: const [
//                     CustomText(
//                       text: "White Shoes",
//                       size: 18,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Row(
//                   children: const [
//                     CustomText(
//                       text: "Nike",
//                       color: Colors.grey,
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const CustomText(
//                       text: "\$18.0",
//                       size: 20,
//                       weight: FontWeight.bold,
//                     ),
//                     const SizedBox(
//                       width: 100,
//                     ),
//                     IconButton(
//                         icon: const Icon(Icons.add_shopping_cart),
//                         onPressed: () {})
//                   ],
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
