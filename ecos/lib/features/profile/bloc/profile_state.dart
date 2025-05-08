part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitialState extends ProfileState {}

final class ProfileRequestState extends ProfileState {}

final class ProfileLoadingSuccessState extends ProfileState {
  const ProfileLoadingSuccessState({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

final class ProfileLoadingFailureState extends ProfileState {
  const ProfileLoadingFailureState({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}
