// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

// Project imports:
import 'package:pay_qr/config/app_constants.dart';
import 'package:pay_qr/config/controllers.dart';
import 'package:pay_qr/model/cart_item.dart';
import 'package:pay_qr/model/product_model.dart';
import 'package:pay_qr/model/user_model.dart';

class CartController extends GetxController {
  static CartController instance = Get.find();
  RxDouble totalCartPrice = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    ever(userController.userModel, changeCartTotalPrice);
  }

  void addProductToCart(ProductModel product) {
    try {
      if (_isItemAlreadyAdded(product)) {
        Get.snackbar("Check your cart", "${product.title} is already added");
      } else {
        var itemId = const Uuid();

        userController.updateUserData({
          "cart": FieldValue.arrayUnion([
            {
              "id": itemId.v4(),
              "productId": product.id,
              "name": product.title,
              "quantity": 1,
              "price": product.price,
              "image": product.imageUrl,
              "cost": product.price
            }
          ])
        });
        Get.snackbar("Item added", "${product.title} was added to your cart");
      }
    } catch (e) {
      Get.snackbar("Error", "Cannot add this item");
      debugPrint(e.toString());
    }
  }

  void removeCartItem(CartItemModel cartItem) {
    try {
      userController.updateUserData({
        "cart": FieldValue.arrayRemove([cartItem.toMap()])
      });
    } catch (e) {
      Get.snackbar("Error", "Cannot remove this item");
      // debugPrint(e);
      logger.e(e);
    }
  }

  changeCartTotalPrice(UserModel userModel) {
    totalCartPrice.value = 0.0;
    if (userModel.cart!.isNotEmpty) {
      for (var cartItem in userModel.cart!) {
        totalCartPrice.value += cartItem.cost!;
      }
    }
  }

  bool _isItemAlreadyAdded(ProductModel product) =>
      userController.userModel.value.cart
          ?.where((item) => item.productId == product.id)
          .isNotEmpty ??
      false;

  void decreaseQuantity(CartItemModel item) {
    if (item.quantity == 1) {
      removeCartItem(item);
    } else {
      removeCartItem(item);
      logger.d(item.quantity);
      int itemQuantity = item.quantity ?? 0;
      itemQuantity--;
      //? getting updated item from copy with
      item = item.copyWith(quantity: itemQuantity);
      logger.d(item.quantity);
      userController.updateUserData({
        "cart": FieldValue.arrayUnion([item.toMap()])
      });
    }
  }

  void increaseQuantity(CartItemModel item) {
    removeCartItem(item);
    logger.i('Initial');
    logger.d(item.quantity);

    int itemQuantity = item.quantity ?? 0;
    itemQuantity++;
    //? getting updated item from copy with
    item = item.copyWith(quantity: itemQuantity);

    logger.i('Item after increment');
    logger.i("quantity ${item.quantity}");
    userController.updateUserData({
      "cart": FieldValue.arrayUnion([item.toMap()])
    });
  }
}
