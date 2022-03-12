// Dart imports:
import 'dart:convert';

class QrModel {
  final String uid;
  final String? shopName;
  final String? productId;
  final String? productName;
  QrModel({
    required this.uid,
    this.shopName,
    this.productId,
    this.productName,
  });

  QrModel copyWith({
    String? uid,
    String? shopName,
    String? productId,
    String? productName,
  }) {
    return QrModel(
      uid: uid ?? this.uid,
      shopName: shopName ?? this.shopName,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'shopName': shopName,
      'productId': productId,
      'productName': productName,
    };
  }

  factory QrModel.fromMap(Map<String, dynamic> map) {
    return QrModel(
      uid: map['uid'] ?? '',
      shopName: map['shopName'],
      productId: map['productId'],
      productName: map['productName'],
    );
  }
  QrModel.fromSnapshot(snapshot)
      : uid = snapshot.data()['uid'],
        shopName = snapshot.data()['shopName'],
        productId = snapshot.data()['productId'],
        productName = snapshot.data()['productName'];

  String toJson() => json.encode(toMap());

  factory QrModel.fromJson(String source) =>
      QrModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'QrModel(uid: $uid, shopName: $shopName, productId: $productId, productName: $productName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is QrModel &&
        other.uid == uid &&
        other.shopName == shopName &&
        other.productId == productId &&
        other.productName == productName;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        shopName.hashCode ^
        productId.hashCode ^
        productName.hashCode;
  }
}
