part of 'register_bloc.dart';

@immutable
sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitialState extends RegisterState {}

final class RegisterRequestState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {
  const RegisterSuccessState({
    required this.baseInformation,
  });

  final BaseInformation baseInformation;

  @override
  List<Object> get props => [baseInformation];
}

final class RegisterFailureState extends RegisterState {
  const RegisterFailureState({
    required this.error,
    required this.errorMessage,
  });

  final Object error;
  final String errorMessage;

  @override
  List<Object> get props => [error, errorMessage];
}
