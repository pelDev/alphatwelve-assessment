import 'package:alphatwelve/core/constants/hero_tags.dart';
import 'package:alphatwelve/core/theme/app_colors.dart';
import 'package:alphatwelve/core/widgets/animated_page_route_content.dart';
import 'package:alphatwelve/core/widgets/go_back.dart';
import 'package:alphatwelve/features/cart/presentation/providers/cart_provider.dart';
import 'package:alphatwelve/features/cart/presentation/widgets/cart_item_widget.dart';
import 'package:alphatwelve/root/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().loadCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                const CustomAppBar(
                  heroTag: AppHeroTags.appBarTag,
                  showFlexibleSpace: false,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverGoBackDelegate(
                    minHeight: kToolbarHeight,
                    maxHeight: kToolbarHeight,
                    child: const GoBack(title: "Your Cart"),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  sliver:
                      cartProvider.items.length > 0 || cartProvider.isLoading
                          ? SliverAnimatedList(
                              key: cartProvider.listKey,
                              initialItemCount: cartProvider.items.length,
                              itemBuilder: (context, index, animation) {
                                final cartItem = cartProvider.items[index];
                                return AnimatedPageRouteContent(
                                  child: CartItemWidget(
                                    item: cartItem,
                                    animation: animation,
                                  ),
                                );
                              },
                            )
                          : const SliverPadding(
                              padding: EdgeInsets.only(top: 80),
                              sliver: SliverToBoxAdapter(
                                child: Center(
                                  child: Text(
                                      "You do not have any items in your cart"),
                                ),
                              ),
                            ),
                ),
              ],
            ),
            if (cartProvider.items.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 16,
                right: 16,
                child: AnimatedPageRouteContent(
                  child: Container(
                    color: AppColor.backgroundLight,
                    padding: const EdgeInsets.only(top: 16, bottom: 16),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                          "Checkout ${cartProvider.totalAmount.toString()}"),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
