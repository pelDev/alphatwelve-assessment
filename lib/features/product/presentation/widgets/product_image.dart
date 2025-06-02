import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imageUrl;
  final String productId;
  final double? height;
  final double? width;

  const ProductImage({
    super.key,
    required this.imageUrl,
    required this.productId,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8.62),
      ),
      clipBehavior: Clip.antiAlias,
      child: Hero(
        tag: "product-$productId",
        child: Image.asset(
          imageUrl,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
