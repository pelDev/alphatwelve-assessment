import 'package:alphatwelve/core/utils/format_currency.dart';

class CartEntity {
  final String productId;
  final String name;
  final double price;
  final String imageUrl;
  final String currency;
  final int quantity;

  CartEntity({
    required this.productId,
    required this.name,
    required this.price,
    required this.currency,
    required this.imageUrl,
    required this.quantity,
  });

  double get totalPrice => price * quantity;

  String get formattedTotalPrice => formatCurrency(totalPrice, currency);

  CartEntity copyWith({int? quantity}) {
    return CartEntity(
      productId: productId,
      name: name,
      price: price,
      currency: currency,
      imageUrl: imageUrl,
      quantity: quantity ?? this.quantity,
    );
  }
}
