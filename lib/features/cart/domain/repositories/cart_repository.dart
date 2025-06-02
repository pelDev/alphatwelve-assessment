import 'package:alphatwelve/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<List<CartEntity>> getCartItems();
  Future<void> addToCart(CartEntity item);
  Future<void> removeFromCart(String productId);
  Future<void> clearCart();
  Future<void> updateQuantity(String productId, int newQuantity);
}
