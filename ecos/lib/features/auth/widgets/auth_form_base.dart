import 'package:flutter/material.dart';

import 'package:ecos/features/auth/auth.dart';
import 'package:ecos/ui/core/validation/validation.dart';

abstract class AuthFormBase<T extends StatefulWidget> extends State<T> {
  final key = GlobalKey<FormState>();

  late AuthFormState state;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    state = AuthFormState();
    emailController = TextEditingController()..addListener(_onEmailChanged);
    passwordController = TextEditingController()
      ..addListener(_onPasswordChanged);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    setState(() {
      state = state.copyWith(email: Email.dirty(emailController.text));
    });
  }

  void _onPasswordChanged() {
    setState(() {
      state = state.copyWith(password: Password.dirty(passwordController.text));
    });
  }

  void resetForm() {
    key.currentState!.reset();
    emailController.clear();
    passwordController.clear();
    setState(() => state = AuthFormState());
  }

  Future<void> submitForm();
}
