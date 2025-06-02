import 'package:alphatwelve/core/icons/app_icons.dart';
import 'package:alphatwelve/core/icons/custom_icon.dart';
import 'package:alphatwelve/core/theme/app_colors.dart';
import 'package:alphatwelve/features/cart/domain/entities/cart_entity.dart';
import 'package:alphatwelve/features/cart/presentation/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartItemWidget extends StatelessWidget {
  final CartEntity item;
  final ValueChanged<int>? onQuantityChanged;
  final Animation<double> animation;

  const CartItemWidget({
    super.key,
    required this.item,
    this.onQuantityChanged,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.read<CartProvider>();

    final actionButtonStyles = Theme.of(context)
        .iconButtonTheme
        .style
        ?.copyWith(shape: WidgetStateProperty.resolveWith(
      (states) {
        return const CircleBorder(
          side: BorderSide(
            width: 1,
            color: AppColor.gray200,
          ),
        );
      },
    ));

    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    item.imageUrl,
                    width: 102.87,
                    height: 106.15,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          color: AppColor.gray700,
                          fontSize: 12,
                          height: 1.8,
                          fontWeight: FontWeight.normal,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.formattedTotalPrice,
                        style: const TextStyle(
                          color: AppColor.gray700,
                          fontSize: 17,
                          height: 1.8,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "In Stock",
                        style: TextStyle(
                          color: AppColor.success500,
                          fontSize: 12,
                          height: 1.4,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          IconButton(
                            icon: const CustomIcon(
                              assetPath: AppIcons.minus,
                              size: 20,
                            ),
                            onPressed: item.quantity == 1
                                ? null
                                : () => cartProvider.updateItemQuantity(
                                      productId: item.productId,
                                      newQuantity: item.quantity - 1,
                                    ),
                            style: actionButtonStyles,
                          ),
                          const SizedBox(width: 12),
                          Text(item.quantity.toString()),
                          const SizedBox(width: 12),
                          IconButton(
                            icon: const CustomIcon(
                              assetPath: AppIcons.plus,
                              size: 20,
                            ),
                            onPressed: () => cartProvider.updateItemQuantity(
                              productId: item.productId,
                              newQuantity: item.quantity + 1,
                            ),
                            style: actionButtonStyles,
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () =>
                                cartProvider.removeItem(item.productId),
                            icon: const CustomIcon(
                              assetPath: AppIcons.bin,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
