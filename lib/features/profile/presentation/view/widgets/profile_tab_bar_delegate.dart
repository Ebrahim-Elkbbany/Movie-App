import 'package:flutter/material.dart';

class ProfileTabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget tabBar;

  ProfileTabBarDelegate(this.tabBar);

  @override
  double get minExtent => 49.0;
  
  @override
  double get maxExtent => 49.0;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(ProfileTabBarDelegate oldDelegate) {
    return false;
  }
}
