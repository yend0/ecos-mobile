part of 'account_bloc.dart';

@immutable
sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class AccountRequestEvent extends AccountEvent {
  const AccountRequestEvent({
    this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class AccountUpdateEvent extends AccountEvent {
  const AccountUpdateEvent({
    this.completer,
    this.file,
    this.fileName,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.birthDate,
  });

  final Completer? completer;
  final String firstName;
  final String middleName;
  final String lastName;
  final DateTime? birthDate;
  final File? file;
  final String? fileName;

  @override
  List<Object?> get props => [
        completer,
        firstName,
        middleName,
        lastName,
        birthDate,
        file,
        fileName,
      ];
}
