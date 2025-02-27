import 'package:flutter/material.dart';

mixin L10n {
  static List<Locale> get supportedLocales => [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
      ];

  static Locale get fallbackLocale => Locale('ru', 'RU');

  static String get pathToLocalization => 'assets/translations';
}
