import 'package:alphatwelve/core/icons/app_icons.dart';
import 'package:alphatwelve/core/icons/custom_icon.dart';
import 'package:alphatwelve/core/utils/format_currency.dart';
import 'package:alphatwelve/core/widgets/custom_toast.dart';
import 'package:alphatwelve/features/cart/domain/entities/cart_entity.dart';
import 'package:alphatwelve/features/cart/domain/usecases/add_to_cart.dart';
import 'package:alphatwelve/features/cart/domain/usecases/clear_cart.dart';
import 'package:alphatwelve/features/cart/domain/usecases/get_cart_items.dart';
import 'package:alphatwelve/features/cart/domain/usecases/remove_from_cart.dart';
import 'package:alphatwelve/features/cart/domain/usecases/update_cart_item.dart';
import 'package:alphatwelve/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartProvider with ChangeNotifier {
  final GlobalKey<SliverAnimatedListState> listKey = GlobalKey();

  final GetCartItemsUseCase getCartItems;
  final AddToCartUseCase addToCart;
  final UpdateCartItemQuantityUseCase updateCartItem;
  final RemoveFromCartUseCase removeFromCart;
  final ClearCartUseCase clearCart;

  List<CartEntity> _items = [];
  bool _isLoading = false;

  CartProvider({
    required this.getCartItems,
    required this.addToCart,
    required this.removeFromCart,
    required this.clearCart,
    required this.updateCartItem,
  });

  List<CartEntity> get items => _items;
  bool get isLoading => _isLoading;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  String get totalAmount => formatCurrency(
        _items.fold(0, (sum, item) => sum + item.totalPrice),
        'USD',
      ); // TODO: Fix hard-coded currency

  Future<void> loadCartItems() async {
    _isLoading = true;
    notifyListeners();

    _items = await getCartItems();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addItem(BuildContext context, CartEntity newItem) async {
    final existingIndex = _items.indexWhere(
      (item) => item.productId == newItem.productId,
    );

    if (existingIndex >= 0) {
      await updateItemQuantity(
        productId: newItem.productId,
        newQuantity: _items[existingIndex].quantity + newItem.quantity,
      );
    } else {
      await addToCart(newItem);
      await loadCartItems();
    }

    HapticFeedback.lightImpact();

    if (context.mounted) {
      CustomToast.show(
        context: context,
        message: "Item has been added to cart",
        position: ToastPosition.top,
        margin: const EdgeInsets.only(top: kToolbarHeight, left: 16, right: 16),
        icon: const CustomIcon(assetPath: AppIcons.check),
      );
    }
  }

  Future<void> updateItemQuantity({
    required String productId,
    required int newQuantity,
  }) async {
    if (newQuantity <= 0) {
      return;
    }

    final existingIndex =
        _items.indexWhere((item) => item.productId == productId);
    if (existingIndex < 0) return;

    final existingItem = _items[existingIndex];

    if (existingItem.quantity == newQuantity) return;

    final updatedItem = existingItem.copyWith(quantity: newQuantity);

    debugPrint(
        "Existing $existingIndex ${existingItem.quantity} $newQuantity ${updatedItem.quantity}");

    await updateCartItem(updatedItem);
    await loadCartItems();
  }

  Future<void> removeItem(String productId) async {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index == -1) return;

    listKey.currentState?.removeItem(
      index,
      (context, animation) => CartItemWidget(
        item: _items[index],
        animation: animation,
      ),
      duration: const Duration(milliseconds: 300),
    );

    try {
      await removeFromCart(productId);
    } catch (e) {
      debugPrint(e.toString());
    }

    await Future.delayed(const Duration(milliseconds: 350));
    await loadCartItems();
  }

  Future<void> clearAllItems() async {
    await clearCart();
    await loadCartItems();
  }
}
