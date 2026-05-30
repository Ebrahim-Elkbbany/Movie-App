import 'package:flutter/material.dart';

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
  final Color shadowColor;

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
    required this.shadowColor,
  });

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
      shadowColor: shadowColor,
    );
  }

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
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
    );
  }

  static const Color _primaryYellow = Color(0xFFF6BD00);
  static const Color _secondaryGreen = Color(0xFF57AA53);

  static const Color _darkBg = Color(0xFF121312);
  static const Color _darkSurface = Color(0xFF282A28);
  static const Color _white = Color(0xFFFFFFFF);
  static const Color _lightBg = Color(0xFFF5F5F5);
  static const Color _lightSurface = Color(0xFFE8E8E8);
  static const Color _darkShadow = Color(0xFF2A2C30);
  static const Color _black = Color(0xFF1A1A1A);
  static const Color _grayA9 = Color(0xFFA9A9A9);
  static const Color _whiteD9 = Color(0xFFD9D9D9);

  static const Color _error = Color(0xFFE82626);
  static const Color _errorLight = Color(0xFFD32F2F);

  static const Color _disabledLight = Color(0xFFE0E0E0);
  static const Color _disabledDark = Color(0xFF424242);

  static const Color _warningLight = Color(0xFFED6C02);
  static const Color _warningDark = Color(0xFFFFA726);

  static const light = AppColorsExtension(
    primary: _darkBg,
    secondary: _secondaryGreen,
    textPrimary: _white,
    textSecondary: _grayA9,
    background: _lightBg,
    surface: _lightSurface,
    iconColor: _black,
    buttonColor: _primaryYellow,
    disabledColor: _disabledLight,
    error: _errorLight,
    success: _secondaryGreen,
    warning: _warningLight,
    shadowColor: _darkShadow,
    
  );

  static const dark = AppColorsExtension(
    primary: _primaryYellow,
    secondary: _secondaryGreen,
    textPrimary: _white,
    textSecondary: _whiteD9,
    background: _darkBg,
    surface: _darkSurface,
    iconColor: _white,
    buttonColor: _primaryYellow,
    disabledColor: _disabledDark,
    error: _error,
    success: _secondaryGreen,
    warning: _warningDark,
    shadowColor: _darkShadow,
  );
}
