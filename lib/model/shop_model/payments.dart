// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/foundation.dart';

class PaymentsModel {
  static const ID = "id";
  static const PAYMENT_ID = "paymentId";
  static const CART = "cart";
  static const AMOUNT = "amount";
  static const STATUS = "status";
  static const CREATED_AT = "createdAt";

  String id;
  String paymentId;
  String amount;
  String status;
  int createdAt;
  List cart;
  PaymentsModel({
    required this.id,
    required this.paymentId,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.cart,
  });

  // PaymentsModel({this.id, this.paymentId, this.amount, this.status, this.createdAt, this.cart});

  // PaymentsModel.fromMap(Map data){
  //   id = data[ID];
  //   createdAt = data[CREATED_AT];
  //   paymentId = data[PAYMENT_ID];
  //   amount = data[AMOUNT];
  //   status = data[STATUS];
  //   cart = data[CART];
  // }

  PaymentsModel copyWith({
    String? id,
    String? paymentId,
    String? amount,
    String? status,
    int? createdAt,
    List? cart,
  }) {
    return PaymentsModel(
      id: id ?? this.id,
      paymentId: paymentId ?? this.paymentId,
      amount: amount ?? this.amount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      cart: cart ?? this.cart,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paymentId': paymentId,
      'amount': amount,
      'status': status,
      'createdAt': createdAt,
      'cart': cart,
    };
  }

  factory PaymentsModel.fromMap(Map<String, dynamic> map) {
    return PaymentsModel(
      id: map['id'] ?? '',
      paymentId: map['paymentId'] ?? '',
      amount: map['amount'] ?? '',
      status: map['status'] ?? '',
      createdAt: map['createdAt']?.toInt() ?? 0,
      cart: List.from(map['cart']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentsModel.fromJson(String source) =>
      PaymentsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PaymentsModel(id: $id, paymentId: $paymentId, amount: $amount, status: $status, createdAt: $createdAt, cart: $cart)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentsModel &&
        other.id == id &&
        other.paymentId == paymentId &&
        other.amount == amount &&
        other.status == status &&
        other.createdAt == createdAt &&
        listEquals(other.cart, cart);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        paymentId.hashCode ^
        amount.hashCode ^
        status.hashCode ^
        createdAt.hashCode ^
        cart.hashCode;
  }
}
