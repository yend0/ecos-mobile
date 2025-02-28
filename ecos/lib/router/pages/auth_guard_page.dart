import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ecos/router/router.dart';
import 'package:ecos/features/auth/auth.dart';

class AuthGuardPage extends StatefulWidget {
  const AuthGuardPage({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  _AuthGuardPageState createState() => _AuthGuardPageState();
}

class _AuthGuardPageState extends State<AuthGuardPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthCheckLoginInAppEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthorizedState) {
          return widget.child;
        } else if (state is AuthRequestState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => context.go(PAGES.login.screenPath),
          );
          return const SizedBox.shrink();
        }
      },
    );
  }
}
