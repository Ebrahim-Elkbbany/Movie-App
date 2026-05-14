import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';

class AppTheme {
  static ThemeData get lightTheme =>
      _buildTheme(AppColorsExtension.light, Brightness.dark);
  static ThemeData get darkTheme =>
      _buildTheme(AppColorsExtension.dark, Brightness.light);

  static ThemeData _buildTheme(
    AppColorsExtension colors,
    Brightness statusIconBrightness,
  ) {
    return ThemeData(
      fontFamily: 'Cairo',
      scaffoldBackgroundColor: colors.background,
      extensions: [colors],
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
        selectionColor: colors.primary.withValues(alpha: 0.3),
        selectionHandleColor: colors.primary,
      ),

      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: colors.background,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        hintStyle: FontStyles.font16Regular.copyWith(
          color: colors.textSecondary,
        ),
        errorStyle: TextStyle(color: colors.error, fontSize: 12.sp),
        border: _outlineBorder(colors.surface),
        enabledBorder: _outlineBorder(colors.surface),
        focusedBorder: _outlineBorder(colors.primary),
        errorBorder: _outlineBorder(colors.error),
        focusedErrorBorder: _outlineBorder(colors.error),
        disabledBorder: _outlineBorder(colors.disabledColor),
      ),

      // 🔵 Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          textStyle: FontStyles.font16SemiBold,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),

      // 🟣 Card & Divider Theme
      cardTheme: CardThemeData(
        color: colors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: colors.surface,
        thickness: 1,
        space: 20.h,
      ),

      // 🔴 Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),

      // 🟡 Text Theme
      textTheme: TextTheme(
        displayLarge: FontStyles.font50SemiBold.copyWith(
          color: colors.textPrimary,
        ),
        titleLarge: FontStyles.font20SemiBold.copyWith(
          color: colors.textPrimary,
        ),
        bodyLarge: FontStyles.font16SemiBold.copyWith(
          color: colors.textPrimary,
        ),
        bodyMedium: FontStyles.font16Regular.copyWith(
          color: colors.textSecondary,
        ),
        bodySmall: FontStyles.font14Bold.copyWith(color: colors.textPrimary),
      ),

      // ⚪ AppBar Theme
      appBarTheme: AppBarTheme(
        titleTextStyle: FontStyles.font20SemiBold.copyWith(
          color: colors.textPrimary,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.iconColor, size: 24.sp),
        backgroundColor: colors.background,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: statusIconBrightness,
          systemNavigationBarColor: colors.background,
          systemNavigationBarIconBrightness: statusIconBrightness,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.background,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }

  static OutlineInputBorder _outlineBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.r),
    borderSide: BorderSide(color: color),
  );
}
