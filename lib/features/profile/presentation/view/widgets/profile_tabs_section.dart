import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';
import 'package:movie_app/core/utils/constants/app_assets.dart';
import 'package:movie_app/core/widgets/movie_card.dart';
import 'package:movie_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';


class ProfileTabBar extends StatelessWidget {
  const ProfileTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return TabBar(
      indicatorColor: colors.primary,
      indicatorWeight: 3,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white.withValues(alpha: 0.6),
      labelStyle: FontStyles.font16SemiBold,
      unselectedLabelStyle: FontStyles.font16Regular,
      tabs: [
        Tab(
          height: 72.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.format_list_bulleted,
                color: colors.primary,
                size: 26.sp,
              ),
              SizedBox(height: 6.h),
              const Text('Watch List'),
            ],
          ),
        ),
        Tab(
          height: 72.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder,
                color: colors.primary,
                size: 26.sp,
              ),
              SizedBox(height: 6.h),
              const Text('History'),
            ],
          ),
        ),
      ],
    );
  }
}

class ProfileTabsSection extends StatelessWidget {
  const ProfileTabsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return TabBarView(
      children: [
        _buildStreamGrid(cubit.watchlistStream),
        _buildStreamGrid(cubit.historyStream),
      ],
    );
  }

  Widget _buildStreamGrid(Stream<List<Map<String, dynamic>>> stream) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final items = snapshot.data ?? [];
        if (items.isEmpty) {
          return _buildEmptyState();
        }

        return GridView.builder(
          padding: EdgeInsets.all(16.w),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 122 / 179.58, // Exact dimensions from figma
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final movie = items[index];
            return MovieCard(movieData: movie); // Will pass data once movie card supports it
          },
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Image.asset(
        AppImages.empty, // using the empty popcorn state
        width: 150.w,
        height: 150.h,
        fit: BoxFit.contain,
      ),
    );
  }
}
