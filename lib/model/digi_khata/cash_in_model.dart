import 'dart:convert';

class CashModel {
  final String date;
  final double liye;
  final double diye;
  CashModel({
    required this.date,
    required this.liye,
    required this.diye,
  });

  CashModel copyWith({
    String? date,
    double? liye,
    double? diye,
  }) {
    return CashModel(
      date: date ?? this.date,
      liye: liye ?? this.liye,
      diye: diye ?? this.diye,
    );
  }

  CashModel.fromSnapshot(snapshot)
      : date = snapshot.data()['date'],
        liye = snapshot.data()['liye'],
        diye = snapshot.data()['diye'];

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'date': date});
    result.addAll({'liye': liye});
    result.addAll({'diye': diye});

    return result;
  }

  factory CashModel.fromMap(Map<String, dynamic> map) {
    return CashModel(
      date: map['date'] ?? '',
      liye: map['liye']?.toDouble() ?? 0.0,
      diye: map['diye']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CashModel.fromJson(String source) =>
      CashModel.fromMap(json.decode(source));

  @override
  String toString() => 'CashModel(date: $date, liye: $liye, diye: $diye)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CashModel &&
        other.date == date &&
        other.liye == liye &&
        other.diye == diye;
  }

  @override
  int get hashCode => date.hashCode ^ liye.hashCode ^ diye.hashCode;
}
