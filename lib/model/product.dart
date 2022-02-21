// Dart imports:
import 'dart:convert';

import 'package:pay_qr/model/qr_model.dart';

// Project imports:

class Product {
  // final String id;
  final String title;
  final String description;
  final double price;
  final double? numberOfViews;
  final QrModel? qr;
  final String? imageUrl;
  Product({
    required this.title,
    required this.description,
    required this.price,
    this.numberOfViews,
    this.qr,
    this.imageUrl,
  });

  Product copyWith({
    String? title,
    String? description,
    double? price,
    double? numberOfViews,
    QrModel? qr,
    String? imageUrl,
  }) {
    return Product(
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
      'title': title,
      'description': description,
      'price': price,
      'numberOfViews': numberOfViews,
      'qr': qr?.toMap(),
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      numberOfViews: map['numberOfViews']?.toDouble(),
      qr: map['qr'] != null ? QrModel.fromMap(map['qr']) : null,
      imageUrl: map['imageUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(title: $title, description: $description, price: $price, numberOfViews: $numberOfViews, qr: $qr, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.numberOfViews == numberOfViews &&
        other.qr == qr &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        numberOfViews.hashCode ^
        qr.hashCode ^
        imageUrl.hashCode;
  }
}
