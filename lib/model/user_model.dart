// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Project imports:
import 'cart_item.dart';

class UserModel {
  final String? uid;
  final String? fullName;
  final String? email;
  final String? password;
  final String? shopName;
  final bool? isMerchant;
  final String? imageUrl;
  final List<CartItemModel>? cart;
  UserModel({
    this.uid,
    this.fullName,
    this.email,
    this.password,
    this.shopName,
    this.isMerchant,
    this.imageUrl,
    this.cart,
  });

  UserModel copyWith({
    String? uid,
    String? fullName,
    String? email,
    String? password,
    String? shopName,
    bool? isMerchant,
    String? imageUrl,
    List<CartItemModel>? cart,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      shopName: shopName ?? this.shopName,
      isMerchant: isMerchant ?? this.isMerchant,
      imageUrl: imageUrl ?? this.imageUrl,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'password': password,
      'shopName': shopName,
      'isMerchant': isMerchant,
      'imageUrl': imageUrl,
      'cart': cart?.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      shopName: map['shopName'],
      isMerchant: map['isMerchant'] ?? false,
      imageUrl: map['imageUrl'],
      cart: List<CartItemModel>.from(
          map['cart']?.map((x) => CartItemModel.fromMap(x))),
    );
  }

  static List<CartItemModel> _convertCartItems(List cartFomDb) {
    List<CartItemModel> result = [];
    if (cartFomDb.isNotEmpty) {
      for (var element in cartFomDb) {
        result.add(CartItemModel.fromMap(element));
      }
    }
    return result;
  }

  UserModel.fromSnapshot(snapshot)
      : uid = snapshot.data()['uid'],
        fullName = snapshot.data()['fullName'],
        email = snapshot.data()['email'],
        password = snapshot.data()['password'],
        shopName = snapshot.data()['shopName'],
        isMerchant = snapshot.data()['isMerchant'],
        imageUrl = snapshot.data()['imageUrl'],
        cart = _convertCartItems(snapshot.data()['cart'] ?? []);

  List cartItemsToJson() => cart!.map((item) => item.toMap()).toList();
  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(uid: $uid, fullName: $fullName, email: $email, password: $password, shopName: $shopName, isMerchant: $isMerchant, imageUrl: $imageUrl, cart: $cart)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.uid == uid &&
        other.fullName == fullName &&
        other.email == email &&
        other.password == password &&
        other.shopName == shopName &&
        other.isMerchant == isMerchant &&
        other.imageUrl == imageUrl &&
        listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        fullName.hashCode ^
        email.hashCode ^
        password.hashCode ^
        shopName.hashCode ^
        isMerchant.hashCode ^
        imageUrl.hashCode ^
        cart.hashCode;
  }
}
