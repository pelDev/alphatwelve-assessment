import 'package:alphatwelve/core/constants/hero_tags.dart';
import 'package:alphatwelve/core/icons/app_icons.dart';
import 'package:alphatwelve/core/icons/custom_icon.dart';
import 'package:alphatwelve/core/widgets/dissmiss_keyboard.dart';
import 'package:alphatwelve/core/widgets/go_back.dart';
import 'package:alphatwelve/features/cart/presentation/providers/cart_provider.dart';
import 'package:alphatwelve/features/cart/presentation/screens/cart_screen.dart';
import 'package:alphatwelve/features/product/presentation/providers/product_provider.dart';
import 'package:alphatwelve/root/presentation/navigation_provider.dart';
import 'package:alphatwelve/root/widgets/custom_app_bar.dart';
import 'package:alphatwelve/root/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final GlobalKey _nestedScrollKey = GlobalKey();
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToCart(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return const CartScreen();
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        reverseTransitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final cartProvider = context.watch<CartProvider>();
    final navProvider = context.watch<NavigationProvider>();

    return DismissKeyboard(
      child: Scaffold(
        body: NestedScrollView(
          key: _nestedScrollKey,
          headerSliverBuilder: (context, _) {
            return [
              CustomAppBar(
                showFlexibleSpace: navProvider.currentIndex == 0,
                heroTag: AppHeroTags.appBarTag,
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverGoBackDelegate(
                  minHeight: kToolbarHeight,
                  maxHeight: kToolbarHeight,
                  child: GoBack(
                      title: productProvider.selectedCategory.name,
                      isDisabled: navProvider.currentIndex == 0,
                      onTap: () {
                        _pageController.animateTo(
                          0,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }),
                ),
              ),
            ];
          },
          body: Builder(builder: (context) {
            return PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: navProvider.setCurrentIndex,
              children: navProvider.screens,
            );
          }),
        ),
        bottomNavigationBar: navProvider.currentIndex == 0
            ? _buildCustomBottomBar(navProvider, cartProvider)
            : null,
      ),
    );
  }

  Widget _buildCustomBottomBar(
      NavigationProvider navProvider, CartProvider cartProvider) {
    return Container(
      color: Colors.white.withValues(alpha: 0.95),
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 16),
      child: SafeArea(
        child: SizedBox(
          // height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const NavItem(
                isActive: true,
                title: "Home",
                icon: CustomIcon(
                  assetPath: AppIcons.home,
                  size: 24,
                ),
              ),
              NavItem(
                isActive: false,
                title: "Cart",
                icon: const CustomIcon(
                  assetPath: AppIcons.cart,
                  size: 24,
                ),
                onPress: () => _navigateToCart(context),
                hasBadge: true,
                badgeLabel: cartProvider.items.length.toString(),
              ),
              const NavItem(
                isActive: false,
                title: "Favourites",
                icon: CustomIcon(
                  assetPath: AppIcons.favourite,
                  size: 24,
                ),
              ),
              const NavItem(
                isActive: false,
                title: "Profile",
                icon: CustomIcon(
                  assetPath: AppIcons.userProfile,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
