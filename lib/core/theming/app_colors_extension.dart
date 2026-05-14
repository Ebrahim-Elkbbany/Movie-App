import 'package:flutter/material.dart';

/// [AppColorsExtension] (AR: ملحق الألوان)
/// 
/// This class is a `ThemeExtension` that allows us to define custom colors 
/// that are not part of the standard Material `ColorScheme`.
/// (AR: هذا الكلاس يسمح لنا بتعريف ألوان مخصصة غير موجودة في ColorScheme الافتراضي لـ Flutter)
///
/// ### How to use (AR: كيف تستخدمه):
/// 1. Access it using context: `context.customColors.primary`
/// 2. It automatically switches between light and dark mode based on the theme.
///
/// ### How to add a new color (AR: كيف تضيف لون جديد):
/// 1. Add a new `final Color` field (e.g., `final Color myNewColor;`).
/// 2. Add it to the constructor.
/// 3. Add it to the `copyWith` method.
/// 4. Add it to the `lerp` method (important for smooth transitions).
/// 5. Define its values in the `light` and `dark` static instances at the bottom.
/// 
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  final Color primary;
  final Color secondary;
  final Color textPrimary;
  final Color textSecondary;
  final Color background;
  final Color surface;
  final Color iconColor;
  final Color buttonColor;
  final Color disabledColor;
  final Color error;
  final Color success;
  final Color warning;

  const AppColorsExtension({
    required this.primary,
    required this.secondary,
    required this.textPrimary,
    required this.textSecondary,
    required this.background,
    required this.surface,
    required this.iconColor,
    required this.buttonColor,
    required this.disabledColor,
    required this.error,
    required this.success,
    required this.warning,
  });

  /// [copyWith] (AR: نسخ مع تعديل)
  /// Used by Flutter to create a copy of this object with some fields replaced.
  /// (AR: يستخدم لإنشاء نسخة جديدة من الألوان مع القدرة على تغيير بعضها)
  @override
  AppColorsExtension copyWith({
    Color? primary,
    Color? secondary,
    Color? textPrimary,
    Color? textSecondary,
    Color? background,
    Color? surface,
    Color? iconColor,
    Color? buttonColor,
    Color? disabledColor,
    Color? error,
    Color? success,
    Color? warning,
  }) {
    return AppColorsExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      iconColor: iconColor ?? this.iconColor,
      buttonColor: buttonColor ?? this.buttonColor,
      disabledColor: disabledColor ?? this.disabledColor,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
    );
  }

  /// [lerp] (AR: التداخل الخطي)
  /// Used by Flutter for smooth transitions when switching between light and dark mode.
  /// (AR: يستخدم لعمل انتقال ناعم جداً بين ألوان الوضع الفاتح والغامق)
  @override
  AppColorsExtension lerp(
    covariant ThemeExtension<AppColorsExtension>? other,
    double t,
  ) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t)!,
      error: Color.lerp(error, other.error, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
    );
  }

  // --- Static Raw Colors (AR: الألوان الخام الثابتة) ---
  static const Color _primary = Color(0xff129575);
  static const Color _secondary = Color(0xffFF9C00);
  static const Color _white = Colors.white;
  static const Color _black = Colors.black;
  static const Color _whiteD9 = Color(0xffD9D9D9);
  static const Color _grayA9 = Color(0xffA9A9A9);
  static const Color _black12 = Color(0xff121212);
  static const Color _black18 = Color(0xff181818);
  
  static const Color _disabledLight = Color(0xFFE0E0E0); 
  static const Color _disabledDark = Color(0xFF424242);

  static const Color _errorLight = Color(0xFFD32F2F);
  static const Color _errorDark = Color(0xFFEF5350);
  
  static const Color _successLight = Color(0xFF2E7D32);
  static const Color _successDark = Color(0xFF66BB6A);
  
  static const Color _warningLight = Color(0xFFED6C02);
  static const Color _warningDark = Color(0xFFFFA726);

  /// [light] Mode Configuration (AR: إعدادات الوضع الفاتح)
  static const light = AppColorsExtension(
    primary: _primary,
    secondary: _secondary,
    textPrimary: _black,
    textSecondary: _grayA9,
    background: _white,
    surface: _whiteD9,
    iconColor: _black12,
    buttonColor: _primary,
    disabledColor: _disabledLight,
    error: _errorLight,
    success: _successLight,
    warning: _warningLight,
  );

  /// [dark] Mode Configuration (AR: إعدادات الوضع الغامق)
  static const dark = AppColorsExtension(
    primary: _primary,
    secondary: _secondary,
    textPrimary: _white,
    textSecondary: _whiteD9,
    background: _black,
    surface: _black18,
    iconColor: _white,
    buttonColor: _primary,
    disabledColor: _disabledDark,
    error: _errorDark,
    success: _successDark,
    warning: _warningDark,
  );
}
