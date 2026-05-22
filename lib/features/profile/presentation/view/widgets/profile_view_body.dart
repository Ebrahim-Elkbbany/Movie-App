import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:movie_app/features/profile/presentation/manager/profile_cubit/profile_state.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/profile_action_buttons.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/profile_info_header.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/profile_tabs_section.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/profile_tab_bar_delegate.dart';
import 'package:movie_app/core/widgets/feedback/custom_snack_bar.dart';
import 'package:movie_app/core/navigation/app_routes.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileActionLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(
              child: CircularProgressIndicator(color: Color(0xFFFFBB3B)),
            ),
          );
        } else if (state is ProfileActionError) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          CustomSnackBar.show(context: context, message: state.message, isError: true);
        } else if (state is ProfileLogoutSuccess || state is ProfileDeleteSuccess) {
          if (Navigator.canPop(context)) Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.loginView,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ProfileError) {
          return Center(child: Text(state.message));
        }
        
        final user = context.read<ProfileCubit>().currentUser;
        
        return DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      if (user != null) ProfileInfoHeader(user: user),
                      const SizedBox(height: 24),
                      if (user != null) ProfileActionButtons(user: user),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: ProfileTabBarDelegate(
                    const ProfileTabBar(),
                  ),
                ),
              ];
            },
            body: const ProfileTabsSection(),
          ),
        );
      },
    );
  }
}
