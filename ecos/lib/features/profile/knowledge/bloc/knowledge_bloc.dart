import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:meta/meta.dart';

import 'package:ecos/clients/clients.dart';

part 'knowledge_event.dart';
part 'knowledge_state.dart';

class KnowledgeBloc extends Bloc<KnowledgeEvent, KnowledgeState> {
  KnowledgeBloc({
    required WasteClient wasteClient,
    Talker? logger,
  })  : _wasteClient = wasteClient,
        _logger = logger,
        super(KnowledgeInitialState()) {
    on<KnowledgeRequestEvent>(_getWasteInformation);
    on<KnowledgeChangeLocaleEvent>(_changeLocale);
  }

  final WasteClient _wasteClient;
  final Talker? _logger;
  String _languageCode = 'ru';

  FutureOr<void> _getWasteInformation(
    KnowledgeRequestEvent event,
    Emitter<KnowledgeState> emit,
  ) async {
    try {
      emit(KnowledgeRequestState());

      final List<Waste> wastes = await _wasteClient.getWastesInformation(
        language: _languageCode,
      );

      emit(KnowledgeLoadingSuccessState(wastes: wastes));
    } catch (error, stackTrace) {
      emit(KnowledgeLoadingFailureState(error: error));
      _logger?.handle(error, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }

  void _changeLocale(
    KnowledgeChangeLocaleEvent event,
    Emitter<KnowledgeState> emit,
  ) {
    _languageCode = event.languageCode;
  }
}
