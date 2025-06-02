import 'package:alphatwelve/features/cart/domain/entities/cart_entity.dart';
import 'package:alphatwelve/features/cart/domain/repositories/cart_repository.dart';

class GetCartItemsUseCase {
  final CartRepository repository;

  GetCartItemsUseCase(this.repository);

  Future<List<CartEntity>> call() async {
    return await repository.getCartItems();
  }
}
