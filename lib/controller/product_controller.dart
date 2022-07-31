// Package imports:
import 'package:get/get.dart';
// Project imports:
import 'package:pay_qr/utils/auth_helper_firebase.dart';

import '../model/product_model.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  var isLoading = true.obs;

  RxList<ProductModel> products = RxList<ProductModel>([]);

  void fetchProducts(String uid) async {
    try {
      isLoading(true);
      var products = await AuthHelperFirebase.fetchProducts(uid);
      if (products != null) {
        this.products.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}
