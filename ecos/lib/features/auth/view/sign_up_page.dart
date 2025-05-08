import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ecos/router/router.dart';
import 'package:ecos/ui/core/core.dart';
import 'package:ecos/generated/locale_keys.g.dart';
import 'package:ecos/features/auth/auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends AuthFormBase<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AuthAppBar(
        onBack: () => context.go(PAGES.login.screenPath),
      ),
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {},
        child: Form(
          key: key,
          child: Align(
            heightFactor: 2.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    LocaleKeys.register_text_register.tr(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  BaseTextField(
                    controller: emailController,
                    hintText: LocaleKeys.register_text_email_input.tr(),
                    fieldKey: const Key('signup_emailInput'),
                    validator: (value) =>
                        state.email.validator(value ?? '')?.text(),
                  ),
                  const SizedBox(height: 12),
                  BaseTextField(
                    controller: passwordController,
                    hintText: LocaleKeys.register_text_password_input.tr(),
                    obscureText: true,
                    fieldKey: const Key('signup_passwordInput'),
                    validator: (value) =>
                        state.password.validator(value ?? '')?.text(),
                  ),
                  const SizedBox(height: 24),
                  HelpText(
                    questionText: LocaleKeys.register_text_question_text.tr(),
                    actionText: LocaleKeys.register_text_action_text.tr(),
                    onPressed: () => context.go(PAGES.login.screenPath),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          if (state is RegisterRequestState) {
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
            text: LocaleKeys.register_text_register_button.tr(),
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

    final registerBloc = BlocProvider.of<RegisterBloc>(context);
    final completer = Completer();

    registerBloc.add(RegisterRequestEvent(
      username: emailController.text,
      password: passwordController.text,
      completer: completer,
    ));
    await completer.future;

    if (!mounted) return;

    final registerState = registerBloc.state;

    if (registerState is RegisterFailureState) {
      showSnackBar(
        context: context,
        message: registerState.errorMessage,
        color: Colors.red,
      );
      throw Exception();
    }

    resetForm();
    showSnackBar(
      context: context,
      message: LocaleKeys.register_text_success_snack_bar.tr(),
      color: Colors.green,
    );
    context.go(PAGES.login.screenPath);
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
