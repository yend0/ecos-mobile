import 'dart:async';

import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ecos/router/router.dart';

import 'package:ecos/ui/core/core.dart';
import 'package:ecos/features/auth/auth.dart';

import 'package:ecos/generated/generated.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _key = GlobalKey<FormState>();

  late AuthFormState _state;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _state = AuthFormState();
    _emailController = TextEditingController()..addListener(_onEmailChanged);
    _passwordController = TextEditingController()
      ..addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AuthAppBar(onBack: () => {context.go(PAGES.home.screenPath)}),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {},
        child: Form(
          key: _key,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Align(
                alignment: Alignment(0, -0.4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      LocaleKeys.login_text_login.tr(),
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        key: const Key('myForm_emailInput'),
                        controller: _emailController,
                        textInputAction: TextInputAction.next,
                        validator: (value) =>
                            _state.email.validator(value ?? '')?.text(),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                          hintText: LocaleKeys.login_text_email_input.tr(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextFormField(
                        key: const Key('myForm_passwordInput'),
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        validator: (value) =>
                            _state.password.validator(value ?? '')?.text(),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                          hintText: LocaleKeys.login_text_password_input.tr(),
                          isDense: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    HelpText(
                      questionText: LocaleKeys.login_text_question_text.tr(),
                      actionText: LocaleKeys.login_text_action_text.tr(),
                      onPressed: () => context.go(PAGES.register.screenPath),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthRequestState) {
            return CircularProgressIndicator(
              color: Color(0xFF25884F),
            );
          }
          return GeneralFloatingActionButton(
            theme: ThemeData(primaryColor: Colors.white),
            text: LocaleKeys.login_text_login_button.tr(),
            onPressed: () async {
              await _onSubmit();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _onEmailChanged() {
    setState(() {
      _state = _state.copyWith(email: Email.dirty(_emailController.text));
    });
  }

  void _onPasswordChanged() {
    setState(() {
      _state = _state.copyWith(
        password: Password.dirty(_passwordController.text),
      );
    });
  }

  Future<void> _onSubmit() async {
    if (!_key.currentState!.validate()) return;

    setState(() {
      _state = _state.copyWith(status: FormzSubmissionStatus.inProgress);
    });

    try {
      await _submitForm();
      _state = _state.copyWith(status: FormzSubmissionStatus.success);
    } catch (_) {
      _state = _state.copyWith(status: FormzSubmissionStatus.failure);
    }

    if (!mounted) return;

    setState(() {});

    FocusScope.of(context)
      ..nextFocus()
      ..unfocus();

    final successSnackBar = SnackBar(
      content: Text(LocaleKeys.login_text_success_snack_bar.tr()),
    );
    final failureSnackBar = SnackBar(
      content: Text(LocaleKeys.login_text_failure_snack_bar.tr()),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        _state.status.isSuccess ? successSnackBar : failureSnackBar,
      );

    if (_state.status.isSuccess) _resetForm();
  }

  Future<void> _submitForm() async {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final completer = Completer();

    final String username = _emailController.text;
    final String password = _passwordController.text;

    authBloc.add(AuthAuthorizeEvent(
      username: username,
      password: password,
      completer: completer,
    ));
    await completer.future;

    final authState = authBloc.state;

    if (authState is AuthFailureState) {
      throw Exception();
    }
  }

  void _resetForm() {
    _key.currentState!.reset();
    _emailController.clear();
    _passwordController.clear();
    setState(() => _state = AuthFormState());
    context.go(PAGES.home.screenPath);
  }
}

extension on EmailValidationError {
  String text() {
    switch (this) {
      case EmailValidationError.invalid:
        return LocaleKeys.validations_email_validation_error_invalid.tr();
      case EmailValidationError.empty:
        return LocaleKeys.validations_email_validation_error_empty.tr();
    }
  }
}

extension on PasswordValidationError {
  String text() {
    switch (this) {
      case PasswordValidationError.invalid:
        return LocaleKeys.validations_password_validation_error_invalid.tr();
      case PasswordValidationError.empty:
        return LocaleKeys.validations_password_validation_error_empty.tr();
    }
  }
}
