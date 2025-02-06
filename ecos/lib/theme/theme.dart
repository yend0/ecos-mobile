import 'package:flutter/material.dart';

class EcosAppTheme {
  EcosAppTheme._();

  static const Color _primaryColor = Color(0xFFFFFFFF);
  static const Color _secondaryColor = Color(0xFF25884F);
  static const Color _onSurfaceColor = Color(0xFF000000);
  static const Color _backgroundColor = Color(0xFFEEEFEF);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Outfit',
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _backgroundColor,
    colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor,
      primary: _primaryColor,
      secondary: _secondaryColor,
      onSurface: _onSurfaceColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _backgroundColor,
      foregroundColor: _onSurfaceColor,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: _onSurfaceColor,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: _onSurfaceColor,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: _onSurfaceColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: _onSurfaceColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: _onSurfaceColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: _onSurfaceColor,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: _onSurfaceColor,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: _onSurfaceColor,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _onSurfaceColor,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: _onSurfaceColor,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: _onSurfaceColor,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: _onSurfaceColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: _onSurfaceColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: _onSurfaceColor,
      ),
      bodySmall: TextStyle(
        fontFamily: 'Outfit',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: _onSurfaceColor,
      ),
    ),
    iconTheme: const IconThemeData(color: _onSurfaceColor),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(_secondaryColor),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.all(_secondaryColor),
    ),
  );
}
