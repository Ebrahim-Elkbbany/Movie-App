import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/features/home/presentation/manager/movies_cubit.dart';
import 'package:movie_app/features/home/presentation/manager/search_cubit.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/home_tab_view.dart';
import 'package:movie_app/features/home/presentation/view/search_tab/search_view_tab.dart';
import 'package:movie_app/features/profile/presentation/view/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      BlocProvider(
        create: (_) => getIt<MoviesCubit>()..fetchMovies(),
        child: const HomeTabView(),
      ),
      BlocProvider(
        create: (_) => getIt<SearchCubit>(),
        child: const SearchViewTab(),
      ),
      const _BrowsePlaceholder(),
      const ProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Scaffold(
      backgroundColor: colors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      extendBody: true,
      bottomNavigationBar: _BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        colors: colors,
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.colors,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final AppColorsExtension colors;

  static const _navItems = [
    _NavItem(icon: AppIcons.home, label: 'Home'),
    _NavItem(icon: AppIcons.search, label: 'Search'),
    _NavItem(icon: AppIcons.explore, label: 'Browse'),
    _NavItem(icon: AppIcons.person, label: 'Profile'),
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
          (index) => _NavBarItem(
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

class _NavBarItem extends StatelessWidget {
  const _NavBarItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.colors,
  });

  final _NavItem item;
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

class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final String icon;
  final String label;
}

// Placeholder للـ Browse tab لحد ما صاحبك يخلص شغله
class _BrowsePlaceholder extends StatelessWidget {
  const _BrowsePlaceholder();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Scaffold(
      backgroundColor: colors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcons.explore,
              width: 64.w,
              height: 64.h,
              colorFilter: ColorFilter.mode(colors.textSecondary, BlendMode.srcIn),
            ),
            SizedBox(height: 16.h),
            Text(
              'Browse',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8.h),
            Text(
              'Coming soon...',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
