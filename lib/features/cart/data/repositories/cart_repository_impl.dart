import 'package:alphatwelve/features/cart/data/datasources/cart_datasource.dart';
import 'package:alphatwelve/features/cart/data/models/cart_item_model.dart';
import 'package:alphatwelve/features/cart/domain/entities/cart_entity.dart';
import 'package:alphatwelve/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addToCart(CartEntity item) async {
    await localDataSource.addToCart(CartItemModel.fromEntity(item));
  }

  @override
  Future<void> clearCart() async {
    await localDataSource.clearCart();
  }

  @override
  Future<List<CartEntity>> getCartItems() async {
    return await localDataSource.getCartItems();
  }

  @override
  Future<void> removeFromCart(String productId) async {
    await localDataSource.removeFromCart(productId);
  }

  @override
  Future<void> updateQuantity(String productId, int newQuantity) async {
    await localDataSource.updateQuantity(productId, newQuantity);
  }
}
