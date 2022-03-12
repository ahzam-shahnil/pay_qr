// Dart imports:
import 'dart:convert';

class CartItemModel {
  final String? id;
  final String? image;
  final String? name;
  final int? quantity;
  final double? cost;
  final String? productId;
  final double? price;
  CartItemModel({
    this.id,
    this.image,
    this.name,
    this.quantity,
    this.cost,
    this.productId,
    this.price,
  });

  Map toMap() => {
        'id': id,
        'productId': productId,
        'image': image,
        'name': name,
        'quantity': quantity,
        'cost': price! * quantity!,
        'price': price,
      };

  CartItemModel copyWith({
    String? id,
    String? image,
    String? name,
    int? quantity,
    double? cost,
    String? productId,
    double? price,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      image: image ?? this.image,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      cost: cost ?? this.cost,
      productId: productId ?? this.productId,
      price: price ?? this.price,
    );
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      id: map['id'],
      image: map['image'],
      name: map['name'],
      quantity: map['quantity']?.toInt(),
      cost: map['cost']?.toDouble(),
      productId: map['productId'],
      price: map['price']?.toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItemModel.fromJson(String source) =>
      CartItemModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CartItemModel(id: $id, image: $image, name: $name, quantity: $quantity, cost: $cost, productId: $productId, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItemModel &&
        other.id == id &&
        other.image == image &&
        other.name == name &&
        other.quantity == quantity &&
        other.cost == cost &&
        other.productId == productId &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        image.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        cost.hashCode ^
        productId.hashCode ^
        price.hashCode;
  }
}
