import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/di/service_locator.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/profile/presentation/manager/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/edit_profile_view_body.dart';

class EditProfileView extends StatelessWidget {
  final UserModel userModel;

  const EditProfileView({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(
        getIt(),
        getIt(),
      )..initData(userModel),
      child: const Scaffold(
        body: SafeArea(
          child: EditProfileViewBody(),
        ),
      ),
    );
  }
}
