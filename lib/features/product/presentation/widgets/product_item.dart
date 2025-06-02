import 'package:alphatwelve/features/product/domain/entities/product_entity.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_image.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_name.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_price.dart';
import 'package:flutter/material.dart';

class ProductListItem extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const ProductListItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductImage(
            imageUrl: product.imageUrl,
            productId: product.id,
            height: 162,
            width: double.infinity,
          ),
          const SizedBox(height: 8.0),
          ProductNameWidget(
            name: product.name,
            productId: product.id,
            maxLines: 2,
          ),
          const SizedBox(height: 8.0),
          const Spacer(),
          ProductPriceWidget(
            amount: product.formattedAmount,
            productId: product.id,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black,
              fontSize: 16,
              height: 1,
            ),
          ),
        ],
      ),
    );

    ListTile(
      leading: Image.asset(
        product.imageUrl,
        width: 50,
        height: 50,
      ), // TODO: Should be change to network image with caching.
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
