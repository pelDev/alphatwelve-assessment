import 'package:alphatwelve/core/icons/app_icons.dart';
import 'package:alphatwelve/core/icons/custom_icon.dart';
import 'package:alphatwelve/core/theme/app_colors.dart';
import 'package:alphatwelve/core/widgets/logo_stub.dart';
import 'package:flutter/material.dart';

final _searchInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(5),
  borderSide: const BorderSide(
    color: AppColor.gray200,
    width: 1,
  ),
);

class CustomAppBar extends StatelessWidget {
  final String heroTag;
  final bool showFlexibleSpace;

  const CustomAppBar({
    super.key,
    required this.heroTag,
    required this.showFlexibleSpace,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      leading: const LogoStub(),
      leadingWidth: 70 + 16,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const CustomIcon(
            assetPath: AppIcons.notification,
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
      ],
      scrolledUnderElevation: 0.0,
      title: const Center(
        child: Column(
          children: [
            Text(
              'DELIVERY ADDRESS',
              style: TextStyle(
                fontSize: 10.0,
                height: 2,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Umuezike Road, Oyo State',
              style: TextStyle(
                fontSize: 12.0,
                height: 2.2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      expandedHeight: showFlexibleSpace ? 120 : kToolbarHeight,
      flexibleSpace: showFlexibleSpace
          ? FlexibleSpaceBar(
              background: Hero(
                tag: heroTag,
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + kToolbarHeight,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: _buildSearchInput(),
                ),
              ),
            )
          : null,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0), // Border thickness
        child: Container(
          color: AppColor.gray200,
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildSearchInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: const TextStyle(
          color: AppColor.gray300,
          fontSize: 14,
          height: 1.5,
        ),
        border: _searchInputBorder,
        focusedBorder: _searchInputBorder,
        enabledBorder: _searchInputBorder,
        contentPadding: const EdgeInsets.all(8.0),
        prefixIcon: const CustomIcon(
          assetPath: AppIcons.search,
          size: 12,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }
}
