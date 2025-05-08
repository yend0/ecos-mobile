import 'dart:async';

import 'package:flutter/material.dart';
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

class _SignInPageState extends AuthFormBase<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AuthAppBar(
        onBack: () => context.go(PAGES.home.screenPath),
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {},
        child: Align(
          heightFactor: 2.0,
          child: Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    LocaleKeys.login_text_login.tr(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  BaseTextField(
                    controller: emailController,
                    hintText: LocaleKeys.login_text_email_input.tr(),
                    fieldKey: const Key('signup_emailInput'),
                    validator: (value) =>
                        state.email.validator(value ?? '')?.text(),
                  ),
                  const SizedBox(height: 12),
                  BaseTextField(
                    controller: passwordController,
                    hintText: LocaleKeys.login_text_password_input.tr(),
                    obscureText: true,
                    fieldKey: const Key('signup_passwordInput'),
                    validator: (value) =>
                        state.password.validator(value ?? '')?.text(),
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
      floatingActionButton: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthRequestState) {
            return FloatingActionButton(
              onPressed: null,
              backgroundColor: const Color(0xFF25884F),
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return GeneralFloatingActionButton(
            theme: ThemeData(primaryColor: Colors.white),
            text: LocaleKeys.login_text_login_button.tr(),
            onPressed: () async {
              await submitForm();
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  Future<void> submitForm() async {
    if (!key.currentState!.validate()) return;

    final authBloc = BlocProvider.of<AuthBloc>(context);
    final completer = Completer();

    authBloc.add(AuthAuthorizeEvent(
      username: emailController.text,
      password: passwordController.text,
      completer: completer,
    ));
    await completer.future;

    if (!mounted) return;

    final authenticationState = authBloc.state;

    if (authenticationState is AuthFailureState) {
      showSnackBar(
        context: context,
        message: authenticationState.errorMessage,
        color: Colors.red,
      );
      throw Exception();
    }

    resetForm();

    showSnackBar(
      context: context,
      message: LocaleKeys.login_text_success_snack_bar.tr(),
      color: Colors.green,
    );
    context.go(PAGES.home.screenPath);
  }

  showSnackBar({
    required BuildContext context,
    required message,
    required color,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: color,
      ),
    );
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
