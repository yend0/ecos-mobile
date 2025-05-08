part of 'recycle_bloc.dart';

@immutable
sealed class RecycleState extends Equatable {
  const RecycleState();

  @override
  List<Object> get props => [];
}

final class RecycleInitialState extends RecycleState {}

final class RecycleRequestState extends RecycleState {}

final class RecycleLoadingSuccessState extends RecycleState {
  const RecycleLoadingSuccessState({required this.wastes});

  final List<Waste> wastes;

  @override
  List<Object> get props => [wastes];
}

final class RecycleLoadingFailureState extends RecycleState {
  const RecycleLoadingFailureState({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}
