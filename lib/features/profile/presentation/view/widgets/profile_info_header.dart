import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/features/auth/data/models/user_model.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/profile_avatar_and_name.dart';
import 'package:movie_app/features/profile/presentation/view/widgets/profile_stat_column.dart';

class ProfileInfoHeader extends StatelessWidget {
  final UserModel user;
  const ProfileInfoHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileAvatarAndName(user: user),
          SizedBox(width: 32.w),
          const Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProfileStatColumn(count: '12', label: 'Wish List'),
                ProfileStatColumn(count: '10', label: 'History'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
