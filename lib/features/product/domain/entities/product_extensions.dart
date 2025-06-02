import 'package:alphatwelve/features/cart/domain/entities/cart_entity.dart';
import 'package:alphatwelve/features/product/domain/entities/product_entity.dart';

extension ProductToCartExtension on ProductEntity {
  CartEntity toCartEntity({int quantity = 1}) {
    return CartEntity(
      productId: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      currency: currency,
      quantity: quantity,
    );
  }
}
