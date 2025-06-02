import 'package:alphatwelve/core/utils/format_currency.dart';

class ProductEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String currency;
  final String imageUrl;

  ProductEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.currency,
    required this.price,
    required this.imageUrl,
  });

  String get formattedAmount => formatCurrency(price, currency);
}
