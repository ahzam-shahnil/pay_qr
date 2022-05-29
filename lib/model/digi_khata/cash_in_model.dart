import 'dart:convert';

class CashModel {
  final String date;
  final double paisay;
  final String details;
  final bool isMainDiye;
  CashModel({
    required this.date,
    required this.paisay,
    required this.details,
    required this.isMainDiye,
  });

  CashModel copyWith({
    String? date,
    double? paisay,
    String? details,
    bool? isMainDiye,
  }) {
    return CashModel(
      date: date ?? this.date,
      paisay: paisay ?? this.paisay,
      details: details ?? this.details,
      isMainDiye: isMainDiye ?? this.isMainDiye,
    );
  }

  CashModel.fromSnapshot(snapshot)
      : date = snapshot.data()['date'],
        paisay = snapshot.data()['paisay'],
        isMainDiye = snapshot.data()['isMainDiye'],
        details = snapshot.data()['details'];
  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'paisay': paisay,
      'details': details,
      'isMainDiye': isMainDiye,
    };
  }

  factory CashModel.fromMap(Map<String, dynamic> map) {
    return CashModel(
      date: map['date'] ?? '',
      paisay: map['paisay']?.toDouble() ?? 0.0,
      details: map['details'] ?? '',
      isMainDiye: map['isMainDiye'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CashModel.fromJson(String source) =>
      CashModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CashModel(date: $date, paisay: $paisay, details: $details, isMainDiye: $isMainDiye)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CashModel &&
        other.date == date &&
        other.paisay == paisay &&
        other.details == details &&
        other.isMainDiye == isMainDiye;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        paisay.hashCode ^
        details.hashCode ^
        isMainDiye.hashCode;
  }
}
