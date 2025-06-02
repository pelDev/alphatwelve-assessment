import 'package:alphatwelve/features/cart/data/datasources/cart_datasource.dart';
import 'package:alphatwelve/features/cart/data/datasources/cart_local_datasource.dart';
import 'package:alphatwelve/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:alphatwelve/features/cart/domain/repositories/cart_repository.dart';
import 'package:alphatwelve/features/cart/domain/usecases/add_to_cart.dart';
import 'package:alphatwelve/features/cart/domain/usecases/clear_cart.dart';
import 'package:alphatwelve/features/cart/domain/usecases/get_cart_items.dart';
import 'package:alphatwelve/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:alphatwelve/features/cart/domain/usecases/update_cart_item.dart';
import 'package:alphatwelve/features/cart/presentation/providers/cart_provider.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class CartInjection {
  static List<SingleChildWidget> providers = [
    Provider<CartLocalDataSource>(
      create: (_) => CartLocalDataSourceImpl(Hive),
    ),
    Provider<CartRepository>(
      create: (context) => CartRepositoryImpl(
        localDataSource: context.read<CartLocalDataSource>(),
      ),
    ),
    Provider<GetCartItemsUseCase>(
      create: (context) => GetCartItemsUseCase(context.read<CartRepository>()),
    ),
    Provider<AddToCartUseCase>(
      create: (context) => AddToCartUseCase(context.read<CartRepository>()),
    ),
    Provider<RemoveFromCartUseCase>(
      create: (context) =>
          RemoveFromCartUseCase(context.read<CartRepository>()),
    ),
    Provider<ClearCartUseCase>(
      create: (context) => ClearCartUseCase(context.read<CartRepository>()),
    ),
    Provider<UpdateCartItemQuantityUseCase>(
      create: (context) =>
          UpdateCartItemQuantityUseCase(context.read<CartRepository>()),
    ),
    ChangeNotifierProvider<CartProvider>(
      create: (context) => CartProvider(
        getCartItems: context.read<GetCartItemsUseCase>(),
        addToCart: context.read<AddToCartUseCase>(),
        removeFromCart: context.read<RemoveFromCartUseCase>(),
        clearCart: context.read<ClearCartUseCase>(),
        updateCartItem: context.read<UpdateCartItemQuantityUseCase>(),
      ),
    ),
  ];
}
