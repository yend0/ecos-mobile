part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckLoginInAppEvent extends AuthEvent {}

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

class AuthRefreshEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}
