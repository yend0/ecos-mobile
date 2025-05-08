import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
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

      final userJson = jsonEncode({
        "first_name": event.firstName,
        "middle_name": event.middleName,
        "last_name": event.lastName,
        "birth_date": event.birthDate?.toIso8601String(),
      });

      if (event.file == null) {
        final formData = FormData.fromMap({
          'data': userJson,
        });
        final User user = await _userClient.updateAccountInformation(
          token: 'Bearer $accessToken',
          formData: formData,
        );
        emit(AccountLoadingSuccessState(user: user));
      } else {
        final formData = FormData.fromMap({
          event.fileName!: event.file,
          'data': userJson,
        });
        final User user = await _userClient.updateAccountInformation(
          token: 'Bearer $accessToken',
          filenames: event.fileName,
          formData: formData,
        );
        emit(AccountLoadingSuccessState(user: user));
      }
    } catch (error, stackTrace) {
      emit(AccountLoadingFailureState(error: error));
      _logger?.handle(error, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }
}
