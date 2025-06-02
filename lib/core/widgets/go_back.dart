import 'dart:math';

import 'package:alphatwelve/core/constants/hero_tags.dart';
import 'package:alphatwelve/core/icons/app_icons.dart';
import 'package:alphatwelve/core/icons/custom_icon.dart';
import 'package:flutter/material.dart';

class GoBack extends StatelessWidget {
  final String title;
  final bool isDisabled;
  final VoidCallback? onTap;

  const GoBack({
    super.key,
    required this.title,
    this.isDisabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: AppHeroTags.goBackNav,
      child: GestureDetector(
        onTap: !isDisabled ? onTap ?? () => Navigator.pop(context) : null,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1,
                color: Color(0xffF5F5F5),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomIcon(assetPath: AppIcons.back, size: 10),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  height: 1,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                  fontFamily: 'IBMPlexSans',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverGoBackDelegate extends SliverPersistentHeaderDelegate {
  SliverGoBackDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  double get maxExtent => max(maxHeight, minHeight);

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverGoBackDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
