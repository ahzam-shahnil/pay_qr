// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:get/get.dart';

// // Project imports:
// import 'package:pay_qr/config/app_constants.dart';
// import 'package:pay_qr/config/controllers.dart';
// import 'package:pay_qr/model/product_model.dart';
// import 'package:pay_qr/widgets/shared/blur_image.dart';
// import 'package:pay_qr/widgets/shop_new/custom_text.dart';

// class SingleProductWidget extends StatelessWidget {
//   final ProductModel product;

//   const SingleProductWidget({Key? key, required this.product})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(15),
//           boxShadow: [
//             BoxShadow(
//                 color: Colors.grey.withOpacity(.5),
//                 offset: const Offset(3, 2),
//                 blurRadius: 7)
//           ]),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ClipRRect(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(15),
//                   topRight: Radius.circular(15),
//                 ),
//                 child: FancyShimmerImage(
//                   width: double.infinity,
//                   height: Get.size.height * 0.2,
//                   boxFit: BoxFit.scaleDown,
//                   imageUrl: product.imageUrl!,
//                   errorWidget: const BlurImage(),
//                 )),
//           ),
//           CustomText(
//             text: product.title,
//             size: 18,
//             weight: FontWeight.bold,
//           ),
//           CustomText(
//             text: product.description,
//             color: Colors.grey,
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 8.0),
//                 child: CustomText(
//                   text: "\$${product.price}",
//                   size: 22,
//                   weight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 width: 30,
//               ),
//               IconButton(
//                   color: kPrimaryColor,
//                   icon: const Icon(Icons.add_shopping_cart),
//                   onPressed: () {
//                     cartController.addProductToCart(product);
//                   })
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
