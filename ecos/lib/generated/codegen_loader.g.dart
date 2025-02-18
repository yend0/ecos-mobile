// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ru_RU = {
  "title_hello": "Привет!",
  "title_card": "Заработанные баллы",
  "feature_card_description": {
    "find_bucket": "Найти пункт",
    "add_bucket": "Добавить пункт",
    "history": "История",
    "knowledge_base": "База знаний"
  },
  "title_description": {
    "last_contribution": "Последний вклад",
    "settings": "Настройки",
    "help": "Помощь и поддержка"
  },
  "root_label": {
    "home": "Главная",
    "recycle": "Переработка",
    "profile": "Профиль"
  },
  "buttons": {
    "account": "Ваша учетная запись",
    "languages": "Языки",
    "faq": "FAQ"
  },
  "points": "бал."
};
static const Map<String,dynamic> _en_US = {
  "title_hello": "Hey!",
  "title_card": "Points earned",
  "feature_card_description": {
    "find_bucket": "Find a bin",
    "add_bucket": "Add bin",
    "history": "History",
    "knowledge_base": "Knowledge base"
  },
  "title_description": {
    "last_contribution": "Last deposit",
    "settings": "Settings",
    "help": "Help and support"
  },
  "root_label": {
    "home": "Home",
    "recycle": "Recycling",
    "profile": "Profile"
  },
  "buttons": {
    "account": "Your account",
    "languages": "Languages",
    "faq": "FAQ"
  },
  "points": "points"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru_RU": _ru_RU, "en_US": _en_US};
}
