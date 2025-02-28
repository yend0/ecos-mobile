part of 'auth_bloc.dart';

@immutable
sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthRequestState extends AuthState {}

final class AuthAuthorizedState extends AuthState {
  const AuthAuthorizedState({
    required this.accessToken,
    required this.refreshToken,
  });

  final String accessToken;
  final String refreshToken;

  @override
  List<Object> get props => [accessToken, refreshToken];
}

final class AuthUnAuthorizedState extends AuthState {}

final class AuthFailureState extends AuthState {
  const AuthFailureState({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}
