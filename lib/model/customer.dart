import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:pay_qr/model/digi_khata/cash_model.dart';

class CustomerModel {
  final String id;
  final String name;
  final String phoneNo;
  final List<CashModel> cashRecords;
  CustomerModel({
    required this.id,
    required this.name,
    required this.phoneNo,
    required this.cashRecords,
  });

  CustomerModel copyWith({
    String? id,
    String? name,
    String? phoneNo,
    List<CashModel>? cashRecords,
  }) {
    return CustomerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNo: phoneNo ?? this.phoneNo,
      cashRecords: cashRecords ?? this.cashRecords,
    );
  }

  CustomerModel.fromSnapshot(snapshot)
      : name = snapshot.data()['name'],
        id = snapshot.data()['id'],
        phoneNo = snapshot.data()['phoneNo'],
        cashRecords = List<CashModel>.from(
            snapshot.data()['cashRecords']?.map((x) => CashModel.fromMap(x)));
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNo': phoneNo,
      'cashRecords': cashRecords.map((x) => x.toMap()).toList(),
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      cashRecords: List<CashModel>.from(
          map['cashRecords']?.map((x) => CashModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerModel.fromJson(String source) =>
      CustomerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CustomerModel(id: $id, name: $name, phoneNo: $phoneNo, cashRecords: $cashRecords)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomerModel &&
        other.id == id &&
        other.name == name &&
        other.phoneNo == phoneNo &&
        listEquals(other.cashRecords, cashRecords);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNo.hashCode ^
        cashRecords.hashCode;
  }
}
