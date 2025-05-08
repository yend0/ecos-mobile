part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckLoginInAppEvent extends AuthEvent {
  const AuthCheckLoginInAppEvent({
    this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class AuthAuthorizeEvent extends AuthEvent {
  const AuthAuthorizeEvent({
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

class AuthRefreshEvent extends AuthEvent {
  const AuthRefreshEvent({
    this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent({
    this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
