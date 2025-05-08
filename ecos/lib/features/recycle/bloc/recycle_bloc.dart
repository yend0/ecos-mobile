import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:meta/meta.dart';

import 'package:ecos/clients/clients.dart';

part 'recycle_event.dart';
part 'recycle_state.dart';

class RecycleBloc extends Bloc<RecycleEvent, RecycleState> {
  RecycleBloc({
    required WasteClient wasteClient,
    Talker? logger,
  })  : _wasteClient = wasteClient,
        _logger = logger,
        super(RecycleInitialState()) {
    on<RecycleRequestEvent>(_getWasteInformation);
    on<RecycleChangeLocaleEvent>(_changeLocale);
  }

  final WasteClient _wasteClient;
  final Talker? _logger;
  String _languageCode = 'ru';

  FutureOr<void> _getWasteInformation(
    RecycleRequestEvent event,
    Emitter<RecycleState> emit,
  ) async {
    try {
      emit(RecycleRequestState());

      final List<Waste> wastes = await _wasteClient.getWastesInformation(
        language: _languageCode,
      );

      emit(RecycleLoadingSuccessState(wastes: wastes));
    } catch (error, stackTrace) {
      emit(RecycleLoadingFailureState(error: error));
      _logger?.handle(error, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _changeLocale(
    RecycleChangeLocaleEvent event,
    Emitter<RecycleState> emit,
  ) async {
    _languageCode = event.languageCode;
    add(const RecycleRequestEvent());
  }
}
