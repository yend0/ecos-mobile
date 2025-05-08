import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ecos/router/router.dart';

import 'package:ecos/features/home/home.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/features/recycle/recycle.dart';
import 'package:ecos/features/root/root.dart';
import 'package:ecos/features/profile/localization/localization.dart';
import 'package:ecos/features/auth/auth.dart';

import 'package:ecos/clients/clients.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final _router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    routes: [
      // BottomNavigationBar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            RootPage(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: PAGES.home.screenPath,
                name: PAGES.home.screenName,
                builder: (context, state) => const HomePage(),
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: PAGES.recycle.screenPath,
                name: PAGES.recycle.screenName,
                builder: (context, state) => const RecyclePage(),
              )
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: PAGES.profile.screenPath,
                name: PAGES.profile.screenName,
                pageBuilder: (context, state) {
                  return CustomTransitionPage(
                    child: AuthGuardPage(child: const ProfilePage()),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  );
                },
                builder: (context, state) => const ProfilePage(),
                routes: [
                  GoRoute(
                    path: PAGES.account.screenPath,
                    name: PAGES.account.screenName,
                    builder: (context, state) {
                      final user = state.extra as User;
                      return AccountPage(user: user);
                    },
                  ),
                  GoRoute(
                    path: PAGES.localization.screenPath,
                    name: PAGES.localization.screenName,
                    builder: (context, state) => const LocalizationPage(),
                  ),
                  GoRoute(
                      path: PAGES.history.screenPath,
                      name: PAGES.history.screenName,
                      builder: (context, state) {
                        final accrualHistories =
                            state.extra as List<AccuralHistory>;
                        return HistoryPage(accrualHistories: accrualHistories);
                      }),
                  GoRoute(
                    path: PAGES.knowledgeBase.screenPath,
                    name: PAGES.knowledgeBase.screenName,
                    builder: (context, state) => const KnowledgeBasePage(),
                    routes: [
                      GoRoute(
                        path: PAGES.knowledgeDetail.screenPath,
                        name: PAGES.knowledgeDetail.screenName,
                        builder: (context, state) {
                          final waste = state.extra as Waste;
                          return KnowledgeDetailPage(waste: waste);
                        },
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
      GoRoute(
        path: PAGES.login.screenPath,
        name: PAGES.login.screenName,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: PAGES.register.screenPath,
        name: PAGES.register.screenName,
        builder: (context, state) => const SignUpPage(),
      ),
    ],
    redirect: (context, state) async {
      final authState = context.read<AuthBloc>().state;

      if (authState is AuthInitialState) {
        final complete = Completer();
        context
            .read<AuthBloc>()
            .add(AuthCheckLoginInAppEvent(completer: complete));
        await complete.future;
      }

      final isLoggedIn = authState is AuthAuthorizedState;

      final isGoingToProfile = state.fullPath == PAGES.profile.screenPath;
      final isGoingToLogin = state.fullPath == PAGES.login.screenPath;
      final isGoingToRegister = state.fullPath == PAGES.register.screenPath;

      if (!isLoggedIn && isGoingToProfile) return PAGES.login.screenPath;

      if (!isLoggedIn && isGoingToRegister) return PAGES.register.screenPath;

      if (isLoggedIn && isGoingToProfile) return PAGES.profile.screenPath;

      if (isLoggedIn && isGoingToLogin) return PAGES.home.screenPath;

      return null;
    },
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}
