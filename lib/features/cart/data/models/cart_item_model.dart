import 'package:alphatwelve/features/cart/domain/entities/cart_entity.dart';

class CartItemModel extends CartEntity {
  CartItemModel({
    required super.productId,
    required super.name,
    required super.price,
    required super.imageUrl,
    required super.quantity,
    required super.currency,
  });

  factory CartItemModel.fromEntity(CartEntity entity) {
    return CartItemModel(
      productId: entity.productId,
      name: entity.name,
      price: entity.price,
      imageUrl: entity.imageUrl,
      quantity: entity.quantity,
      currency: entity.currency,
    );
  }

  factory CartItemModel.fromJson(Map<dynamic, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      name: json['name'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      quantity: json['quantity'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'quantity': quantity,
      'currency': currency,
    };
  }

  @override
  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      productId: productId,
      name: name,
      price: price,
      currency: currency,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}
