part of 'knowledge_bloc.dart';

@immutable
sealed class KnowledgeEvent extends Equatable {
  const KnowledgeEvent();

  @override
  List<Object?> get props => [];
}

class KnowledgeChangeLocaleEvent extends KnowledgeEvent {
  const KnowledgeChangeLocaleEvent({
    required this.languageCode,
  });

  final String languageCode;

  @override
  List<Object> get props => [languageCode];
}

class KnowledgeRequestEvent extends KnowledgeEvent {
  const KnowledgeRequestEvent({
    this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
