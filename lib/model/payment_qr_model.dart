// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PaymentQrModel {
  final String name;
  final String uid;
  PaymentQrModel({
    required this.name,
    required this.uid,
  });

  PaymentQrModel copyWith({
    String? name,
    String? uid,
  }) {
    return PaymentQrModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, String>{
      'name': name,
      'uid': uid,
    };
  }

  factory PaymentQrModel.fromMap(Map<String, dynamic> map) {
    return PaymentQrModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentQrModel.fromJson(String source) =>
      PaymentQrModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PaymentQrModel(name: $name, uid: $uid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentQrModel && other.name == name && other.uid == uid;
  }

  @override
  int get hashCode => name.hashCode ^ uid.hashCode;
}
