import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/core/theming/app_colors_extension.dart';
import 'package:movie_app/core/theming/font_styles.dart';

class AppTheme {
  static ThemeData get lightTheme =>
      _buildTheme(AppColorsExtension.light, Brightness.light, Brightness.dark);
  static ThemeData get darkTheme =>
      _buildTheme(AppColorsExtension.dark, Brightness.dark, Brightness.light);

  static ThemeData _buildTheme(
    AppColorsExtension colors,
    Brightness brightness,
    Brightness statusIconBrightness,
  ) {
    return ThemeData(
      brightness: brightness,
      fontFamily: 'Cairo',
      scaffoldBackgroundColor: colors.primary,
      extensions: [colors],
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.primary,
        selectionColor: colors.primary.withValues(alpha: 0.3),
        selectionHandleColor: colors.primary,
      ),

      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: colors.surface,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        hintStyle: FontStyles.font14Regular.copyWith(color: colors.textPrimary),
        errorStyle: TextStyle(color: colors.error, fontSize: 12.sp),
        border: _outlineBorder(colors.surface),
        enabledBorder: _outlineBorder(colors.surface),
        focusedBorder: _outlineBorder(colors.primary),
        errorBorder: _outlineBorder(colors.error),
        focusedErrorBorder: _outlineBorder(colors.error),
        disabledBorder: _outlineBorder(colors.disabledColor),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.buttonColor,
          foregroundColor: const Color(0xFF282A28),
          elevation: 0,
          textStyle: FontStyles.font20SemiBold.copyWith(
            fontWeight: FontWeight.w600,
          ),
          minimumSize: Size(double.infinity, 52.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.r)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.primary,
          side: BorderSide(color: colors.primary, width: 1.5),
          elevation: 0,
          textStyle: FontStyles.font16SemiBold,
          minimumSize: Size(double.infinity, 52.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: const Size(0, 0),
          foregroundColor: colors.buttonColor,
          textStyle: FontStyles.font14SemiBold,
        ),
      ),

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

      dialogTheme: DialogThemeData(
        backgroundColor: colors.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
      ),

      textTheme: TextTheme(
        displayLarge: FontStyles.font50SemiBold.copyWith(
          color: colors.textPrimary,
        ),
        headlineMedium: FontStyles.font36Bold.copyWith(
          color: colors.textPrimary,
        ),
        titleLarge: FontStyles.font20SemiBold.copyWith(
          color: colors.textPrimary,
          letterSpacing: 0.15,
        ),
        titleMedium: FontStyles.font18SemiBold.copyWith(
          color: colors.textPrimary,
        ),
        bodyLarge: FontStyles.font16SemiBold.copyWith(
          color: colors.textPrimary,
        ),
        bodyMedium: FontStyles.font14Regular.copyWith(
          color: colors.textSecondary,
        ),
        bodySmall: FontStyles.font24Bold.copyWith(
          color: colors.textPrimary,
        ),
        labelLarge: FontStyles.font16SemiBold.copyWith(
          color: colors.textPrimary,
        ),
      ),

      appBarTheme: AppBarTheme(
        titleTextStyle: FontStyles.font20SemiBold.copyWith(
          color: colors.textPrimary,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.iconColor, size: 24.sp),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: statusIconBrightness,
          systemNavigationBarColor: colors.background,
          systemNavigationBarIconBrightness: statusIconBrightness,
        ),
      ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colors.surface,
        selectedItemColor: colors.primary,
        unselectedItemColor: colors.textSecondary,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),

      chipTheme: ChipThemeData(
        backgroundColor: colors.surface,
        selectedColor: colors.primary,
        labelStyle: FontStyles.font12Regular.copyWith(
          color: colors.textPrimary,
        ),
        secondaryLabelStyle: FontStyles.font12Regular.copyWith(
          color: const Color(0xFF121312),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        side: BorderSide.none,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      ),

      tabBarTheme: TabBarThemeData(
        labelColor: colors.primary,
        unselectedLabelColor: colors.textSecondary,
        labelStyle: FontStyles.font14SemiBold,
        unselectedLabelStyle: FontStyles.font14Regular,
        indicatorColor: colors.primary,
        indicatorSize: TabBarIndicatorSize.label,
        dividerColor: Colors.transparent,
      ),

      iconTheme: IconThemeData(color: colors.iconColor, size: 24.sp),

      progressIndicatorTheme: ProgressIndicatorThemeData(color: colors.primary),
    );
  }

  static OutlineInputBorder _outlineBorder(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(15.r),
    borderSide: BorderSide(color: color),
  );
}
