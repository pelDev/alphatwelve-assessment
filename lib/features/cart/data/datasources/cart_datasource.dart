import 'package:alphatwelve/features/cart/data/models/cart_item_model.dart';

abstract class CartDataSource {
  Future<List<CartItemModel>> getCartItems();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(String productId);
  Future<void> clearCart();
  Future<void> updateQuantity(String productId, int newQuantity);
}

abstract class CartLocalDataSource extends CartDataSource {}
