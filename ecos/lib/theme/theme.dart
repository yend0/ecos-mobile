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
      bodyLarge: TextStyle(color: _onSurfaceColor),
      bodyMedium: TextStyle(color: _onSurfaceColor),
      bodySmall: TextStyle(color: _onSurfaceColor),
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
