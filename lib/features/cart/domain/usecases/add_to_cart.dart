import 'package:alphatwelve/features/cart/domain/entities/cart_entity.dart';
import 'package:alphatwelve/features/cart/domain/repositories/cart_repository.dart';

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<void> call(CartEntity item) async {
    return await repository.addToCart(item);
  }
}
