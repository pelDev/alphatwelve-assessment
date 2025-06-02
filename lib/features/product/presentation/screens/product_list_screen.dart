import 'package:alphatwelve/features/product/domain/entities/product_entity.dart';
import 'package:alphatwelve/features/product/presentation/providers/product_provider.dart';
import 'package:alphatwelve/features/product/presentation/screens/product_detail_screen.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch products when the screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProductProvider>().fetchProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            onRefresh: () => provider.fetchProducts(refresh: true),
            child: CustomScrollView(
              slivers: [
                if (provider.error != null && !provider.isLoading)
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Error: ${provider.error}'),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => provider.fetchProducts(),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (provider.products.isEmpty &&
                    provider.error == null &&
                    !provider.isLoading)
                  const SliverToBoxAdapter(
                      child: Center(child: Text('No products available'))),
                if (provider.error == null || provider.isLoading)
                  SliverPadding(
                    padding: const EdgeInsets.all(16),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (_, index) {
                          if (index >= provider.products.length) {
                            return const ProductListItemSkeleton();
                          }

                          final product = provider.products[index];

                          return ProductListItem(
                            product: product,
                            onTap: () => _navigateToDetails(context, product),
                            key: PageStorageKey(product.id),
                          );
                        },
                        addAutomaticKeepAlives: false,
                        addRepaintBoundaries: true,
                        childCount: provider.isLoading
                            ? provider.products.length + 4
                            : provider.products.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 24.0,
                        crossAxisSpacing: 16.0,
                        // childAspectRatio: 0.75,
                        mainAxisExtent: 229,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _navigateToDetails(BuildContext context, ProductEntity product) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return ProductDetailScreen(
            product: product,
          );
        },
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
        reverseTransitionDuration: const Duration(milliseconds: 200),
      ),
    );
  }
}
