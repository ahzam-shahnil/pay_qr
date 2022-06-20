import 'dart:convert';

import 'package:pay_qr/config/app_constants.dart';
import 'package:pluto_grid/pluto_grid.dart';

class CashModel {
  final String id;
  final String date;
  final String paisay;
  final String details;
  final bool isMainDiye;
  CashModel({
    required this.id,
    required this.date,
    required this.paisay,
    required this.details,
    required this.isMainDiye,
  });

  CashModel copyWith({
    String? id,
    String? date,
    String? paisay,
    String? details,
    bool? isMainDiye,
  }) {
    return CashModel(
      id: id ?? this.id,
      date: date ?? this.date,
      paisay: paisay ?? this.paisay,
      details: details ?? this.details,
      isMainDiye: isMainDiye ?? this.isMainDiye,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'paisay': paisay,
      'details': details,
      'isMainDiye': isMainDiye,
    };
  }

  factory CashModel.fromMap(Map<String, dynamic> map) {
    return CashModel(
      id: map['id'] ?? '',
      date: map['date'] ?? '',
      paisay: map['paisay'] ?? '',
      details: map['details'] ?? '',
      isMainDiye: map['isMainDiye'] ?? false,
    );
  }
  CashModel.fromSnapshot(snapshot)
      : date = snapshot.data()['date'],
        paisay = snapshot.data()['paisay'],
        id = snapshot.data()['id'],
        isMainDiye = snapshot.data()['isMainDiye'],
        details = snapshot.data()['details'];

  factory CashModel.fromPlutoCell(Map<String, PlutoCell>? map) {
    String diye = map?['diye']?.value.toString() ?? '0';
    String date = map?['date']?.value;
    double diyeTotal = double.parse(map?['diye']?.value.toString() ?? '0');
    double liye = double.parse(map?['liye']?.value.toString() ?? '0');
    logger.d(date);
    return CashModel(
      date: date.substring(0, date.indexOf('#')),
      paisay: diye != '0' ? diye : map?['liye']?.value.toString() ?? '0',
      details: date.substring(date.indexOf('#') + 1),
      isMainDiye: diyeTotal > liye,
      id: map?['id']?.value,
    );
  }
  factory CashModel.fromCashBookPlutoCell(Map<String, PlutoCell>? map) {
    String date = map?['date']?.value;
    String cashin = map?['cashin']?.value.toString() ?? '';
    double diyeTotal = double.parse(map?['cashout']?.value.toString() ?? '0');
    double liye = double.parse(map?['cashin']?.value.toString() ?? '0');
    logger.d(cashin);
    return CashModel(
      date: date.substring(0, date.indexOf('#')),
      paisay: cashin != '0' ? cashin : map?['cashout']?.value.toString() ?? '0',
      details: date.substring(date.indexOf('#') + 1),
      isMainDiye: diyeTotal > liye,
      id: map?['id']?.value,
    );
  }

  String toJson() => json.encode(toMap());

  factory CashModel.fromJson(String source) =>
      CashModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CashModel(id: $id, date: $date, paisay: $paisay, details: $details, isMainDiye: $isMainDiye)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CashModel &&
        other.id == id &&
        other.date == date &&
        other.paisay == paisay &&
        other.details == details &&
        other.isMainDiye == isMainDiye;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        date.hashCode ^
        paisay.hashCode ^
        details.hashCode ^
        isMainDiye.hashCode;
  }
}
