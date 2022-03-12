// // Flutter imports:
// import 'package:flutter/material.dart';

// // Package imports:
// import 'package:get/get.dart';

// // Project imports:
// import 'package:pay_qr/config/controllers.dart';
// import 'package:pay_qr/model/product_model.dart';
// import 'package:pay_qr/view/main_views/shopping/product_tile.dart';

// class ProductsWidget extends StatelessWidget {
//   const ProductsWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() => GridView.count(
//         crossAxisCount: 2,
//         childAspectRatio: .63,
//         padding: const EdgeInsets.all(10),
//         mainAxisSpacing: 4.0,
//         crossAxisSpacing: 10,
//         children: productsController.products.map((ProductModel product) {
//           return ProductTile(
//             product: product,
//           );
//         }).toList()));
//   }
// }
