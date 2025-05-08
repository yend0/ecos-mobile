part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitialState extends HomeState {}

final class HomeRequestState extends HomeState {}

final class HomeLoadingSuccessState extends HomeState {
  const HomeLoadingSuccessState({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

final class HomeLoadingFailureState extends HomeState {
  const HomeLoadingFailureState({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}
