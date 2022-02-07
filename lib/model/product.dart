const String _jsonKeyProductName = 'name';
const String _jsonKeyProductPrice = 'price';
const String _jsonKeyProductQuantity = 'quantity';

class Product {
  String? name;
  String? price;
  String? quantity;

  Product({
    this.name,
    this.price,
    this.quantity,
  });
  Product.fromJson(Map<String, dynamic> json) {
    name = json[_jsonKeyProductName]?.toString();
    price = json[_jsonKeyProductPrice]?.toString();
    quantity = json[_jsonKeyProductQuantity]?.toString();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data[_jsonKeyProductName] = name;
    data[_jsonKeyProductPrice] = price;
    data[_jsonKeyProductQuantity] = quantity;
    return data;
  }
}
