import 'package:flutter/material.dart';

class ProductNameWidget extends StatelessWidget {
  final String name;
  final String productId;
  final TextStyle? style;
  final int? maxLines;

  const ProductNameWidget({
    super.key,
    required this.name,
    required this.productId,
    this.style,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
        tag: "product-name-$productId}",
        child: Text(
          name,
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
          overflow: TextOverflow.ellipsis,
          softWrap: true,
          textAlign: TextAlign.left,
          maxLines: maxLines,
        ));
  }
}
