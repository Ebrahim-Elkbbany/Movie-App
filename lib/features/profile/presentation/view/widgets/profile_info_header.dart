import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/profile_avatar_and_name.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/profile_stat_column.dart';

class ProfileInfoHeader extends StatelessWidget {
  final UserModel user;
  const ProfileInfoHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final ProfileCubit cubit = context.read<ProfileCubit>();

    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileAvatarAndName(user: user),
          SizedBox(width: 32.w),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: cubit.watchlistStream,
                  builder: (context, snapshot) {
                    final String count =
                        snapshot.hasData ? snapshot.data!.length.toString() : '0';
                    return ProfileStatColumn(
                      count: count,
                      label: 'Wish List',
                    );
                  },
                ),
                StreamBuilder<List<Map<String, dynamic>>>(
                  stream: cubit.historyStream,
                  builder: (context, snapshot) {
                    final String count =
                        snapshot.hasData ? snapshot.data!.length.toString() : '0';
                    return ProfileStatColumn(
                      count: count,
                      label: 'History',
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
