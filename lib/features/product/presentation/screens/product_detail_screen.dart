import 'package:alphatwelve/core/constants/hero_tags.dart';
import 'package:alphatwelve/core/theme/app_colors.dart';
import 'package:alphatwelve/core/widgets/animated_page_route_content.dart';
import 'package:alphatwelve/core/widgets/go_back.dart';
import 'package:alphatwelve/features/cart/presentation/providers/cart_provider.dart';
import 'package:alphatwelve/features/product/domain/entities/product_entity.dart';
import 'package:alphatwelve/features/product/domain/entities/product_extensions.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_image.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_name.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_price.dart';
import 'package:alphatwelve/root/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  final ProductEntity product;

  const ProductDetailScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

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
                    minHeight: 44,
                    maxHeight: 44,
                    child: const GoBack(title: "Go Back"),
                  ),
                ),
                SliverToBoxAdapter(
                    child: AnimatedPageRouteContent(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ProductImage(
                              imageUrl: product.imageUrl,
                              productId: product.id,
                              height: 331.6,
                              width: double.infinity,
                            ),
                            Positioned(
                              top: 16,
                              right: 16,
                              child: AnimatedOpacity(
                                opacity: 1,
                                duration: const Duration(milliseconds: 300),
                                child: IconButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.white),
                                  ),
                                  icon: const Icon(
                                    Icons.favorite_outline,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        ProductNameWidget(
                          name: product.name,
                          productId: product.id,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ProductPriceWidget(
                          amount: product.formattedAmount,
                          productId: product.id,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 32.75,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          product.description,
                          style: const TextStyle(
                            color: Color(0xff999999),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                )),
              ],
            ),
            Positioned(
              bottom: 0,
              left: 16,
              right: 16,
              child: AnimatedPageRouteContent(
                child: Container(
                  color: AppColor.backgroundLight,
                  padding: const EdgeInsets.only(top: 16, bottom: 16),
                  child: ElevatedButton(
                    onPressed: () => cartProvider.addItem(
                      context,
                      product.toCartEntity(),
                    ),
                    child: const Text("Add to cart"),
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
