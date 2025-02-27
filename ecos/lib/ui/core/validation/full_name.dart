import 'package:formz/formz.dart';

enum FullNameValidationError { invalid, empty }

class FullName extends FormzInput<String, FullNameValidationError>
    with FormzInputErrorCacheMixin {
  FullName.pure([super.value = '']) : super.pure();

  FullName.dirty([super.value = '']) : super.dirty();

  static final _fullNameRegExp = RegExp(
    r'^[а-яА-ЯёЁa-zA-Z\s]+$',
  );

  @override
  FullNameValidationError? validator(String value) {
    if (value.isEmpty) {
      return FullNameValidationError.empty;
    } else if (!_fullNameRegExp.hasMatch(value)) {
      return FullNameValidationError.invalid;
    }

    return null;
  }
}
