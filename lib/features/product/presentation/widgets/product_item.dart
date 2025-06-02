import 'package:alphatwelve/core/theme/app_colors.dart';
import 'package:alphatwelve/features/product/domain/entities/product_entity.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_image.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_name.dart';
import 'package:alphatwelve/features/product/presentation/widgets/product_price.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
  }
}

class ProductListItemSkeleton extends StatelessWidget {
  const ProductListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColor.gray700,
          highlightColor: AppColor.gray700.withValues(alpha: 0.3),
          child: Container(
            width: double.infinity,
            height: 162,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8.62),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Shimmer.fromColors(
          baseColor: AppColor.gray700,
          highlightColor: AppColor.gray700.withValues(alpha: 0.3),
          child: Container(
            width: 80,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        const Spacer(),
        Shimmer.fromColors(
          baseColor: AppColor.gray700,
          highlightColor: AppColor.gray700.withValues(alpha: 0.3),
          child: Container(
            width: 120,
            height: 20,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
