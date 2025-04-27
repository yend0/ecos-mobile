part of 'account_bloc.dart';

@immutable
sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object?> get props => [];
}

class AccountUpdateEvent extends AccountEvent {
  const AccountUpdateEvent({
    this.completer,
    required this.user,
  });

  final Completer? completer;
  final User user;

  @override
  List<Object?> get props => [
        completer,
        user,
      ];
}
