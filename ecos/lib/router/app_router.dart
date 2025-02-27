import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos/router/router.dart';

import 'package:ecos/features/home/home.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/features/recycle/recycle.dart';
import 'package:ecos/features/root/root.dart';
import 'package:ecos/features/profile/localization/localization.dart';

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
                builder: (context, state) => const ProfilePage(),
                routes: [
                  GoRoute(
                    path: PAGES.account.screenPath,
                    name: PAGES.account.screenName,
                    builder: (context, state) => const AccountPage(),
                  ),
                  GoRoute(
                    path: PAGES.localization.screenPath,
                    name: PAGES.localization.screenName,
                    builder: (context, state) => const LocalizationPage(),
                  ),
                  GoRoute(
                    path: PAGES.history.screenPath,
                    name: PAGES.history.screenName,
                    builder: (context, state) => const HistoryPage(),
                  ),
                  GoRoute(
                    path: PAGES.knowledgeBase.screenPath,
                    name: PAGES.knowledgeBase.screenName,
                    builder: (context, state) => const KnowledgeBasePage(),
                    routes: [
                      GoRoute(
                        path: PAGES.knowledgeDetail.screenPath,
                        name: PAGES.knowledgeDetail.screenName,
                        builder: (context, state) =>
                            const KnowledgeDetailPage(),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}
