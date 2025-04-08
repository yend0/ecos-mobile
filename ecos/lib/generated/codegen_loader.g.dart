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
    "help": "Help and support",
    "full_name": "Full name",
    "email": "Email",
    "birth_date": "Birth date"
  },
  "root_label": {
    "home": "Home",
    "recycle": "Recycling",
    "profile": "Profile"
  },
  "buttons_route": {
    "account": "Your account",
    "languages": "Languages",
    "faq": "FAQ"
  },
  "buttons_action": {
    "change_image": "Change image"
  },
  "validations": {
    "full_name_validation_error_invalid": "Please make sure that the specified full name is valid",
    "full_name_validation_error_empty": "Please enter a full name",
    "birth_date_validation_error_invalid": "Please make sure that the specified date of birth is valid",
    "birth_date_validation_error_empty": "Please enter an date of birth",
    "birth_date_validation_error_invalidFormat": "Please make sure that the specified date of birth corresponds to \"XX/XX/20XX\"",
    "email_validation_error_invalid": "Please ensure the email entered is valid",
    "email_validation_error_empty": "Please enter an email",
    "password_validation_error_invalid": "Password must be at least 8 characters and contain at least one letter and number",
    "password_validation_error_empty": "Please enter a password"
  },
  "login_text": {
    "login": "Sign-in",
    "login_button": "Sign-in",
    "success_snack_bar": "Sign-in successfully! 🎉",
    "failure_snack_bar": "An error has occurred. Try again later... 🚨",
    "failure_snack_bar_server_error": "Server error. Try again later... 🚨",
    "failure_snack_bar_password_or_email": "Uncorret username or password... 🚨",
    "question_text": "Don't have an account? ",
    "action_text": "Register",
    "email_input": "Enter your email",
    "password_input": "Enter your password"
  },
  "register_text": {
    "register": "Sign-up",
    "register_button": "Sign-up",
    "success_snack_bar": "Account created successfully! 🎉",
    "failure_snack_bar": "An error occurred while creating the account... 🚨",
    "failure_snack_bar_server_error": "Server error. Try again later... 🚨",
    "failure_snack_bar_password_or_email": "Uncorret username or password... 🚨",
    "failure_snack_bar_already_use": "The user with this email already exists... 🚨",
    "question_text": "Already have an account? ",
    "action_text": "Sign-in",
    "email_input": "Enter your email",
    "password_input": "Enter your password"
  },
  "points": "points"
};
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
    "help": "Помощь и поддержка",
    "full_name": "ФИО",
    "email": "Электронная почта",
    "birth_date": "Дата рождения"
  },
  "root_label": {
    "home": "Главная",
    "recycle": "Переработка",
    "profile": "Профиль"
  },
  "buttons_route": {
    "account": "Ваша учетная запись",
    "languages": "Языки",
    "faq": "FAQ"
  },
  "buttons_action": {
    "change_image": "Изменить изображение"
  },
  "validations": {
    "full_name_validation_error_invalid": "Пожалуйста, убедитесь, что указанное полное имя является действительным",
    "full_name_validation_error_empty": "Пожалуйста, введите полное имя",
    "birth_date_validation_error_invalid": "Пожалуйста, убедитесь, что указанная дата рождения действительна",
    "birth_date_validation_error_empty": "Пожалуйста, укажите дату рождения",
    "birth_date_validation_error_invalidFormat": "Пожалуйста, убедитесь, что указанная дата рождения соответствует \"XX/XX/20XX\"",
    "email_validation_error_invalid": "Пожалуйста, убедитесь, что указанный адрес электронной почты валиден",
    "email_validation_error_empty": "Пожалуйста, введите адрес электронной почты",
    "password_validation_error_invalid": "Пароль должен быть не менее 8 символов и содержать хотя бы одну букву и цифру",
    "password_validation_error_empty": "Пожалуйста, введите пароль"
  },
  "login_text": {
    "login": "Вход",
    "login_button": "Войти",
    "success_snack_bar": "Вход выполнен успешно! 🎉",
    "failure_snack_bar": "Возникла ошибка. Попробуйте позже... 🚨",
    "failure_snack_bar_server_error": "Ошибка сервера. Попробуйте позже... 🚨",
    "failure_snack_bar_password_or_email": "Неверные пароль или почта... 🚨",
    "question_text": "Нет аккаунта? ",
    "action_text": "Зарегистрироваться",
    "email_input": "Введите почту",
    "password_input": "Введите пароль"
  },
  "register_text": {
    "register": "Регистрация",
    "register_button": "Зарегистрироваться",
    "success_snack_bar": "Аккаунт успешно создан! 🎉",
    "failure_snack_bar": "Возникла ошибка при создании аккаунта... 🚨",
    "failure_snack_bar_server_error": "Ошибка сервера. Попробуйте позже... 🚨",
    "failure_snack_bar_password_or_email": "Неверные пароль или почта... 🚨",
    "failure_snack_bar_already_use": "Пользователь с таким email уже существует... 🚨",
    "question_text": "Уже есть аккаунт? ",
    "action_text": "Войти",
    "email_input": "Введите почту",
    "password_input": "Введите пароль"
  },
  "points": "бал."
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en_US": _en_US, "ru_RU": _ru_RU};
}
