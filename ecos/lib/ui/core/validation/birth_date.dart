import 'package:formz/formz.dart';

enum BirthDateValidationError { invalid, empty, invalidFormat }

class BirthDate extends FormzInput<String, BirthDateValidationError>
    with FormzInputErrorCacheMixin {
  BirthDate.pure([super.value = '']) : super.pure();

  BirthDate.dirty([super.value = '']) : super.dirty();

  static final _birthDateRegExp = RegExp(
    r'^(0[1-9]|1[0-2])/(0[1-9]|[12][0-9]|3[01])/([0-9]{4})$',
  );

  @override
  BirthDateValidationError? validator(String value) {
    if (value.isEmpty) {
      return BirthDateValidationError.empty;
    } else if (!_birthDateRegExp.hasMatch(value)) {
      return BirthDateValidationError.invalidFormat;
    } else if (!_isValidDate(value)) {
      return BirthDateValidationError.invalid;
    }

    return null;
  }

  bool _isValidDate(String value) {
    final parts = value.split('/');
    final month = int.parse(parts[0]);
    final day = int.parse(parts[1]);
    final year = int.parse(parts[2]);

    if (month < 1 || month > 12) {
      return false;
    }
    if (day < 1) {
      return false;
    }
    if (day > _daysInMonth(month, year)) {
      return false;
    }

    return true;
  }

  int _daysInMonth(int month, int year) {
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return 29;
      }
      return 28;
    }
    if ([4, 6, 9, 11].contains(month)) {
      return 30;
    }
    return 31;
  }
}
