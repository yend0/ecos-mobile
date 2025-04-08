import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:meta/meta.dart';

import 'package:ecos/clients/clients.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({
    required FlutterSecureStorage storage,
    required UserClient userClient,
    Talker? logger,
  })  : _storage = storage,
        _userClient = userClient,
        _logger = logger,
        super(ProfileInitialState()) {
    on<ProfileRequestEvent>(_getProfileInformation);
  }

  final FlutterSecureStorage _storage;
  final UserClient _userClient;
  final Talker? _logger;

  FutureOr<void> _getProfileInformation(
    ProfileRequestEvent event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(ProfileRequestState());

      final accessToken = await _storage.read(key: 'access_token');

      final User user =
          await _userClient.getAccountInformation(token: 'Bearer $accessToken');

      emit(ProfileLoadingSuccessState(user: user));
    } catch (error, stackTrace) {
      emit(ProfileLoadingFailureState(error: error));
      _logger?.handle(error, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }
}
