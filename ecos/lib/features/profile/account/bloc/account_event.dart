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
    this.birthDate,
    this.imageUrl,
    this.fullName,
  });

  final Completer? completer;
  final DateTime? birthDate;
  final String? imageUrl;
  final String? fullName;

  @override
  List<Object?> get props => [
        completer,
        birthDate,
        imageUrl,
        fullName,
      ];
}
