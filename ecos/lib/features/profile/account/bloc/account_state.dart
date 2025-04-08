part of 'account_bloc.dart';

@immutable
sealed class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

final class AccountInitialState extends AccountState {}

final class AccountRequestState extends AccountState {}

final class AccountLoadingSuccessState extends AccountState {
  const AccountLoadingSuccessState({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

final class AccountLoadingFailureState extends AccountState {
  const AccountLoadingFailureState({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}
