part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

class RegisterRequestEvent extends RegisterEvent {
  const RegisterRequestEvent({
    required this.username,
    required this.password,
    this.completer,
  });

  final String username;
  final String password;
  final Completer? completer;

  @override
  List<Object?> get props => [username, password, completer];
}
