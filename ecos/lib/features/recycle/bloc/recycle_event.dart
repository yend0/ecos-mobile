part of 'recycle_bloc.dart';

@immutable
sealed class RecycleEvent extends Equatable {
  const RecycleEvent();

  @override
  List<Object?> get props => [];
}

class RecycleChangeLocaleEvent extends RecycleEvent {
  const RecycleChangeLocaleEvent({
    required this.languageCode,
  });

  final String languageCode;

  @override
  List<Object?> get props => [languageCode];
}

class RecycleRequestEvent extends RecycleEvent {
  const RecycleRequestEvent({
    this.completer,
  });

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
