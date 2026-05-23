import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ProfileCubit>()..fetchUserData(),
      child: const SafeArea(
        child: Scaffold(
          body: ProfileViewBody(),
        ),
      ),
    );
  }
}
