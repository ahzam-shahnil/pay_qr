// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:pay_qr/config/shop/firebase.dart';
// import 'package:pay_qr/model/product.dart';


// class ProducsController extends GetxController {
//   static ProducsController instance = Get.find();
//   RxList<ProductModel> products = RxList<ProductModel>([]);
//   String collection = "products";

//   @override
//   onReady() {
//     super.onReady();
//     products.bindStream(getAllProducts());
//   }

//   Stream<List<ProductModel>> getAllProducts() =>
//       firebaseFirestore.collection(collection).snapshots().map((query) =>
//           query.docs.map((item) => ProductModel.fromMap(item.data())).toList());

// }
