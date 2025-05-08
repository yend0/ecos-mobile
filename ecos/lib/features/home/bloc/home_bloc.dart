import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:meta/meta.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:ecos/clients/clients.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required FlutterSecureStorage storage,
    required UserClient userClient,
    Talker? logger,
  })  : _storage = storage,
        _userClient = userClient,
        _logger = logger,
        super(HomeInitialState()) {
    on<HomeRequestEvent>(_getProfileInformation);
  }

  final FlutterSecureStorage _storage;
  final UserClient _userClient;
  final Talker? _logger;

  FutureOr<void> _getProfileInformation(
    HomeRequestEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      emit(HomeRequestState());

      final accessToken = await _storage.read(key: 'access_token');

      final User user =
          await _userClient.getAccountInformation(token: 'Bearer $accessToken');

      emit(HomeLoadingSuccessState(user: user));
    } catch (error, stackTrace) {
      emit(HomeLoadingFailureState(error: error));
      _logger?.handle(error, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }
}
