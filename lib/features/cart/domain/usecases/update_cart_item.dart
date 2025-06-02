import 'package:alphatwelve/features/cart/domain/entities/cart_entity.dart';
import 'package:alphatwelve/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartItemQuantityUseCase {
  final CartRepository repository;

  UpdateCartItemQuantityUseCase(this.repository);

  Future<void> call(CartEntity updatedItem) async {
    return await repository.updateQuantity(
        updatedItem.productId, updatedItem.quantity);
  }
}
