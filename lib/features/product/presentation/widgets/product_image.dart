import 'package:alphatwelve/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

// class ProductImage extends StatelessWidget {
//   final String imageUrl;
//   final String productId;
//   final double? height;
//   final double? width;
//
//   const ProductImage({
//     super.key,
//     required this.imageUrl,
//     required this.productId,
//     this.height,
//     this.width,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: width,
//       height: height,
//       decoration: BoxDecoration(
//         color: AppColor.cardBackground,
//         borderRadius: BorderRadius.circular(8.62),
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Hero(
//         tag: "product-$productId",
//         child: Image.asset(
//           imageUrl,
//           height: height,
//           width: width,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final String productId;
  final double? height;
  final double? width;
  final bool fadeIn;

  const ProductImage({
    super.key,
    required this.imageUrl,
    required this.productId,
    this.height,
    this.width,
    this.fadeIn = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(8.62),
      ),
      clipBehavior: Clip.antiAlias,
      child: Hero(
        tag: "product-$productId",
        child: Image.asset(
          imageUrl,
          height: height,
          width: width,
          fit: BoxFit.contain,
          // cacheWidth: width != null ? (width! * 2).toInt() : null,
          // cacheHeight: height != null ? (height! * 2).toInt() : null,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (wasSynchronouslyLoaded || !fadeIn) return child;
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
              child: child,
            );
          },
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[200],
            child: const Icon(Icons.broken_image),
          ),
        ),
      ),
    );
  }
}
