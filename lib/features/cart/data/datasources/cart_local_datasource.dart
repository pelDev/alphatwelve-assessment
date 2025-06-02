import 'package:alphatwelve/features/cart/data/datasources/cart_datasource.dart';
import 'package:alphatwelve/features/cart/data/models/cart_item_model.dart';
import 'package:hive/hive.dart';

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final HiveInterface hive;

  CartLocalDataSourceImpl(this.hive);

  @override
  Future<List<CartItemModel>> getCartItems() async {
    final box = await hive.openBox<Map>('cart');
    return box.values.map((json) => CartItemModel.fromJson(json)).toList();
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final box = await hive.openBox<Map>('cart');
    await box.put(item.productId, item.toJson());
  }

  @override
  Future<void> removeFromCart(String productId) async {
    final box = await hive.openBox<Map>('cart');
    await box.delete(productId);
  }

  @override
  Future<void> clearCart() async {
    final box = await hive.openBox<Map>('cart');
    await box.clear();
  }

  @override
  Future<void> updateQuantity(String productId, int newQuantity) async {
    final box = await hive.openBox<Map>('cart');
    final item = CartItemModel.fromJson(box.get(productId)!);
    await box.put(productId, item.copyWith(quantity: newQuantity).toJson());
  }
}
