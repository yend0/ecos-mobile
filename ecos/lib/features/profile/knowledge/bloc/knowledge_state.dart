part of 'knowledge_bloc.dart';

@immutable
sealed class KnowledgeState extends Equatable {
  const KnowledgeState();

  @override
  List<Object> get props => [];
}

final class KnowledgeInitialState extends KnowledgeState {}

final class KnowledgeRequestState extends KnowledgeState {}

final class KnowledgeLoadingSuccessState extends KnowledgeState {
  const KnowledgeLoadingSuccessState({required this.wastes});

  final List<Waste> wastes;

  @override
  List<Object> get props => [wastes];
}

final class KnowledgeLoadingFailureState extends KnowledgeState {
  const KnowledgeLoadingFailureState({required this.error});

  final Object error;

  @override
  List<Object> get props => [error];
}
