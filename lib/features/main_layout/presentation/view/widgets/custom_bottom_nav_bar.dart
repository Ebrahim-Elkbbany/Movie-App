import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';

class NavItem {
  const NavItem({required this.icon, required this.label});
  final String icon;
  final String label;
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.colors,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final AppColorsExtension colors;

  static const _navItems = [
    NavItem(icon: AppIcons.home, label: 'Home'),
    NavItem(icon: AppIcons.search, label: 'Search'),
    NavItem(icon: AppIcons.explore, label: 'Browse'),
    NavItem(icon: AppIcons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(9.w, 0, 9.w, 16.h),
      height: 61.h,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          _navItems.length,
          (index) => CustomNavBarItem(
            item: _navItems[index],
            isSelected: currentIndex == index,
            onTap: () => onTap(index),
            colors: colors,
          ),
        ),
      ),
    );
  }
}

class CustomNavBarItem extends StatelessWidget {
  const CustomNavBarItem({
    super.key,
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.colors,
  });

  final NavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: SvgPicture.asset(
          item.icon,
          width: 24.w,
          height: 24.h,
          colorFilter: ColorFilter.mode(
            isSelected ? colors.primary : colors.textSecondary,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
