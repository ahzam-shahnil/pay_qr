// ignore_for_file: public_member_api_docs, sort_constructors_first
// Dart imports:
import 'dart:convert';

import 'package:flutter/foundation.dart';

// Flutter imports:

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
  final double balance;
  final List<CartItemModel>? cart;
  UserModel({
    this.uid,
    this.fullName,
    this.email,
    this.password,
    this.shopName,
    this.isMerchant,
    this.imageUrl,
    required this.balance,
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
    double? balance,
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
      balance: balance ?? this.balance,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'email': email,
      'password': password,
      'shopName': shopName,
      'isMerchant': isMerchant,
      'imageUrl': imageUrl,
      'balance': balance,
      'cart': cart?.map((x) => x.toMap()).toList(),
    };
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
        balance = snapshot.data()['balance'],
        email = snapshot.data()['email'],
        password = snapshot.data()['password'],
        shopName = snapshot.data()['shopName'],
        isMerchant = snapshot.data()['isMerchant'],
        imageUrl = snapshot.data()['imageUrl'],
        cart = _convertCartItems(snapshot.data()['cart'] ?? []);

  List cartItemsToJson() => cart!.map((item) => item.toMap()).toList();

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      fullName: map['fullName'] != null ? map['fullName'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      shopName: map['shopName'] != null ? map['shopName'] as String : null,
      isMerchant: map['isMerchant'] != null ? map['isMerchant'] as bool : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      balance: map['balance'] as double,
      cart: map['cart'] != null
          ? List<CartItemModel>.from(
              (map['cart'] as List<int>).map<CartItemModel?>(
                (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, fullName: $fullName, email: $email, password: $password, shopName: $shopName, isMerchant: $isMerchant, imageUrl: $imageUrl, balance: $balance, cart: $cart)';
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
        other.balance == balance &&
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
        balance.hashCode ^
        cart.hashCode;
  }
}
