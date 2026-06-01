import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/features/home/presentation/manager/movies_cubit.dart';
import 'package:movie_app/features/search/presentation/manager/search_cubit.dart';
import 'package:movie_app/features/home/presentation/view/home_tab/home_tab_view.dart';
import 'package:movie_app/features/search/presentation/view/search_view.dart';
import 'package:movie_app/features/explore/presentation/view/explore_view.dart';
import 'package:movie_app/features/profile/presentation/view/profile_view.dart';
import 'package:movie_app/features/main_layout/presentation/view/widgets/custom_bottom_nav_bar.dart';

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
      const ExploreView(),
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
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        colors: colors,
      ),
    );
  }
}
