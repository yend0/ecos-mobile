import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:meta/meta.dart';

import 'package:ecos/clients/clients.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required FlutterSecureStorage storage,
    required AuthClient authClient,
    required String clientId,
    required Map<String, String> grantTypes,
    Talker? logger,
  })  : _storage = storage,
        _authClient = authClient,
        _clientId = clientId,
        _grantTypes = grantTypes,
        _logger = logger,
        super(AuthInitialState()) {
    on<AuthCheckLoginInAppEvent>(_checkLoginInApp);
    on<AuthAuthorizeEvent>(_login);
    on<AuthRefreshEvent>(_refresh);
    on<AuthLogoutEvent>(_logout);

    _startTokenValidationTimer();
  }

  final AuthClient _authClient;
  final FlutterSecureStorage _storage;
  final String _clientId;
  final Map<String, String> _grantTypes;
  final Talker? _logger;

  Timer? _tokenValidationTimer;

  void _startTokenValidationTimer() {
    _logger?.debug('Starting token validation timer.');

    _tokenValidationTimer = Timer.periodic(
      const Duration(minutes: 5),
      (_) => add(AuthCheckLoginInAppEvent()),
    );
  }

  FutureOr<void> _checkLoginInApp(
    AuthCheckLoginInAppEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final accessToken = await _storage.read(key: 'access_token');
      final refreshToken = await _storage.read(key: 'refresh_token');

      if (accessToken == null || refreshToken == null) {
        emit(AuthUnAuthorizedState());
        return;
      }

      final UserInfo userInfo =
          await _authClient.userInfo('Bearer $accessToken');

      _logger?.debug('User info: ${userInfo.toJson()}');
      emit(AuthAuthorizedState(
          accessToken: accessToken, refreshToken: refreshToken));
    } catch (error, stackTrace) {
      emit(AuthFailureState(error: error));
      _logger?.handle(error, stackTrace);
      add(AuthRefreshEvent());
    }
  }

  FutureOr<void> _login(
    AuthAuthorizeEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (_tokenValidationTimer == null) {
        _startTokenValidationTimer();
      }

      emit(AuthRequestState());

      final token = await _authClient.login(
        _clientId,
        _grantTypes['password']!,
        event.username,
        event.password,
      );

      await _storage.write(key: 'access_token', value: token.access_token);
      await _storage.write(key: 'refresh_token', value: token.refresh_token);

      emit(AuthAuthorizedState(
          accessToken: token.access_token, refreshToken: token.refresh_token));
    } catch (error, stackTrace) {
      emit(AuthFailureState(error: error));
      _logger?.handle(error, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }

  FutureOr<void> _refresh(
    AuthRefreshEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final refreshToken = await _storage.read(key: 'refresh_token');

      if (refreshToken == null) {
        emit(AuthUnAuthorizedState());
        return;
      }

      emit(AuthRequestState());

      final token = await _authClient.refresh(
        _clientId,
        _grantTypes['refresh_token']!,
        refreshToken,
      );

      await _storage.write(key: 'access_token', value: token.access_token);
      await _storage.write(key: 'refresh_token', value: token.refresh_token);

      emit(AuthAuthorizedState(
          accessToken: token.access_token, refreshToken: token.refresh_token));
    } catch (error, stackTrace) {
      emit(AuthFailureState(error: error));
      _logger?.handle(error, stackTrace);
      emit(AuthUnAuthorizedState());
    }
  }

  FutureOr<void> _logout(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      _tokenValidationTimer?.cancel();

      final refreshToken = await _storage.read(key: 'refresh_token');

      if (refreshToken == null) {
        emit(AuthUnAuthorizedState());
        return;
      }

      await _authClient.logout(
        _clientId,
        refreshToken,
      );

      await _storage.deleteAll();
      emit(AuthUnAuthorizedState());
    } catch (error, stackTrace) {
      emit(AuthFailureState(error: error));
      _logger?.handle(error, stackTrace);
    }
  }

  @override
  Future<void> close() {
    _tokenValidationTimer?.cancel();
    return super.close();
  }
}
