import 'dart:async';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:meta/meta.dart';

import 'package:ecos/clients/clients.dart';
import 'package:ecos/generated/generated.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc({
    required UserClient userClient,
    Talker? logger,
  })  : _logger = logger,
        _userClient = userClient,
        super(RegisterInitialState()) {
    on<RegisterRequestEvent>(_registration);
  }

  final UserClient _userClient;
  final Talker? _logger;

  FutureOr<void> _registration(
    RegisterRequestEvent event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(RegisterRequestState());

      final BaseInformation baseInformation = await _userClient.register(
          email: event.username, password: event.password);

      emit(RegisterSuccessState(baseInformation: baseInformation));
    } catch (error, stackTrace) {
      String errorMessage = LocaleKeys.register_text_failure_snack_bar.tr();

      if (error is DioException) {
        if (error.response?.statusCode == 409) {
          errorMessage =
              LocaleKeys.register_text_failure_snack_bar_already_use.tr();
        } else if (error.response?.statusCode == 422) {
          errorMessage =
              LocaleKeys.register_text_failure_snack_bar_password_or_email.tr();
        } else if (error.response?.statusCode == 500) {
          errorMessage =
              LocaleKeys.register_text_failure_snack_bar_server_error.tr();
        }
      }

      emit(RegisterFailureState(error: error, errorMessage: errorMessage));
      _logger?.handle(error, stackTrace);
    } finally {
      event.completer?.complete();
    }
  }
}
