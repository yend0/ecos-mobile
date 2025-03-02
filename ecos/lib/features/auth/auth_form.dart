import 'package:formz/formz.dart';

import 'package:ecos/ui/core/core.dart';

class AuthFormState with FormzMixin {
  AuthFormState({
    Email? email,
    Password? password,
    this.status = FormzSubmissionStatus.initial,
  })  : email = email ?? Email.pure(),
        password = password ?? Password.pure();

  final Email email;
  final Password password;

  final FormzSubmissionStatus status;

  AuthFormState copyWith({
    Email? email,
    Password? password,
    FormzSubmissionStatus? status,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email, password];
}
