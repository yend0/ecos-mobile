import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecos/features/auth/auth.dart';

class LogoutIconButton extends StatelessWidget {
  const LogoutIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.logout, color: Colors.black),
      onPressed: () async {
        final complete = Completer();

        context.read<AuthBloc>().add(AuthLogoutEvent(completer: complete));
        await complete.future;
      },
    );
  }
}
