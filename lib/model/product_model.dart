// Dart imports:
import 'dart:convert';

// Project imports:
import 'package:pay_qr/model/qr_model.dart';

// Project imports:

class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final double? numberOfViews;
  final QrModel? qr;
  final String? imageUrl;
  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    this.numberOfViews,
    this.qr,
    this.imageUrl,
  });

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    double? numberOfViews,
    QrModel? qr,
    String? imageUrl,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      numberOfViews: numberOfViews ?? this.numberOfViews,
      qr: qr ?? this.qr,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,
      'numberOfViews': numberOfViews,
      'qr': qr?.toMap(),
      'imageUrl': imageUrl,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      numberOfViews: map['numberOfViews']?.toDouble(),
      qr: map['qr'] != null ? QrModel.fromMap(map['qr']) : null,
      imageUrl: map['imageUrl'],
    );
  }
  ProductModel.fromSnapshot(snapshot)
      : id = snapshot.data()['id'],
        title = snapshot.data()['title'],
        description = snapshot.data()['description'],
        price = snapshot.data()['price'],
        numberOfViews = snapshot.data()['numberOfViews'],
        imageUrl = snapshot.data()['imageUrl'],
        qr = snapshot.data()['qr'] != null
            ? QrModel.fromMap(snapshot.data()['qr'])
            : null;

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductModel(id: $id, title: $title, description: $description, price: $price, numberOfViews: $numberOfViews, qr: $qr, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.numberOfViews == numberOfViews &&
        other.qr == qr &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        numberOfViews.hashCode ^
        qr.hashCode ^
        imageUrl.hashCode;
  }
}
