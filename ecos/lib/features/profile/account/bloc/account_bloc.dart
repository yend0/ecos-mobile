import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:meta/meta.dart';

import 'package:ecos/clients/clients.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required FlutterSecureStorage storage,
    required UserClient userClient,
    Talker? logger,
  })  : _storage = storage,
        _userClient = userClient,
        _logger = logger,
        super(AccountInitialState()) {
    on<AccountUpdateEvent>(_updateProfileInformation);
  }

  final FlutterSecureStorage _storage;
  final UserClient _userClient;
  final Talker? _logger;

  FutureOr<void> _updateProfileInformation(
    AccountUpdateEvent event,
    Emitter<AccountState> emit,
  ) async {
    try {
      emit(AccountRequestState());
      final accessToken = await _storage.read(key: 'access_token');

      final User user = await _userClient.updateAccountInformation(
        token: 'Bearer $accessToken',
        data: event.user,
      );

      emit(AccountLoadingSuccessState(user: user));
    } catch (error, stackTrace) {
      emit(AccountLoadingFailureState(error: error));
      _logger?.handle(error, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }
}
