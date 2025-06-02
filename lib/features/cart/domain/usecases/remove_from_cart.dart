import 'package:alphatwelve/features/cart/domain/repositories/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> call(String productId) async {
    return await repository.removeFromCart(productId);
  }
}
