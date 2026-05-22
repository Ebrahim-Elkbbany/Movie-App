import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/utils/change_lang/localization_cubit.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        final cubit = context.read<LocalizationCubit>();
        final isArabic = cubit.isArabic();

        return GestureDetector(
          onTap: () {
            cubit.changeLanguage(isArabic ? 'en' : 'ar');
          },
          child: Container(
            width: 100.w,
            height: 44.h,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(color: colors.primary, width: 2),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: isArabic ? 48.w : 0,
                  right: isArabic ? 0 : 48.w,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primary,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildFlagContainer('🇺🇸'),
                    _buildFlagContainer('🇪🇬'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFlagContainer(String flag) {
    return Container(
      width: 40.w,
      height: 40.h,
      alignment: Alignment.center,
      child: Text(
        flag,
        style: TextStyle(fontSize: 22.sp),
      ),
    );
  }
}
