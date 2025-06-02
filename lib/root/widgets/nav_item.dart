import 'package:alphatwelve/core/icons/custom_icon.dart';
import 'package:alphatwelve/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class NavItem extends StatefulWidget {
  final bool isActive;
  final String title;
  final VoidCallback? onPress;
  final CustomIcon icon;
  final bool hasBadge;
  final String badgeLabel;

  const NavItem({
    super.key,
    required this.isActive,
    required this.title,
    this.onPress,
    required this.icon,
    this.hasBadge = false,
    this.badgeLabel = "",
  });

  @override
  State<NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<NavItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 32,
            width: 56,
            decoration: BoxDecoration(
              color: widget.isActive ? AppColor.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: widget.hasBadge
                  ? Badge(
                      label: Text(widget.badgeLabel),
                      child: CustomIcon(
                        assetPath: widget.icon.assetPath,
                        size: widget.icon.size,
                        color: widget.isActive
                            ? Colors.white
                            : AppColor.surfaceLight,
                      ),
                    )
                  : CustomIcon(
                      assetPath: widget.icon.assetPath,
                      size: widget.icon.size,
                      color: widget.isActive
                          ? Colors.white
                          : AppColor.surfaceLight,
                    ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 12,
              height: 1.2,
              fontWeight: widget.isActive ? FontWeight.w600 : FontWeight.w500,
              color: widget.isActive ? AppColor.primary : AppColor.surfaceLight,
            ),
          ),
        ],
      ),
    );
  }
}
