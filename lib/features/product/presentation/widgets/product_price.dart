import 'package:flutter/material.dart';

class ProductPriceWidget extends StatelessWidget {
  final String amount;
  final String productId;
  final TextStyle? style;

  const ProductPriceWidget({
    super.key,
    required this.amount,
    required this.productId,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "product-price-$productId",
        child: Text(
          amount,
          style: style?.copyWith(
                decoration: TextDecoration.none,
                fontFamily: 'IBMPlexSans',
              ) ??
              const TextStyle(
                fontSize: 14,
                color: Colors.black,
                height: 1.2,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                fontFamily: 'IBMPlexSans',
              ),
          textAlign: TextAlign.left,
        ));
  }
}
