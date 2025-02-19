import 'package:formz/formz.dart';

import 'package:ecos/ui/core/core.dart';

class AccountFormState with FormzMixin {
  AccountFormState({
    Email? email,
    FullName? fullName,
    BirthDate? birthDate,
    this.status = FormzSubmissionStatus.initial,
  })  : email = email ?? Email.pure(),
        fullName = fullName ?? FullName.pure(),
        birthDate = birthDate ?? BirthDate.pure();

  final Email email;
  final FullName fullName;
  final BirthDate birthDate;

  final FormzSubmissionStatus status;

  AccountFormState copyWith({
    Email? email,
    FullName? fullName,
    BirthDate? birthDate,
    FormzSubmissionStatus? status,
  }) {
    return AccountFormState(
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      birthDate: birthDate ?? this.birthDate,
      status: status ?? this.status,
    );
  }

  @override
  List<FormzInput<dynamic, dynamic>> get inputs => [email, fullName, birthDate];
}
