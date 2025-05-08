part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthRequestState extends AuthState {}

final class AuthAuthorizedState extends AuthState {
  const AuthAuthorizedState({
    this.userInfo,
  });

  final UserInfo? userInfo;

  @override
  List<Object?> get props => [userInfo];
}

final class AuthUnAuthorizedState extends AuthState {}

final class AuthFailureState extends AuthState {
  const AuthFailureState({
    required this.error,
    required this.errorMessage,
  });

  final Object error;
  final String errorMessage;

  @override
  List<Object> get props => [error];
}
