import 'package:ecos/features/profile/localization/view/localization_page.dart';
import 'package:go_router/go_router.dart';

import 'package:ecos/features/home/home.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/features/recycle/recycle.dart';
import 'package:ecos/features/root/root.dart';

final router = GoRouter(
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
              path: '/home',
              builder: (context, state) => const HomePage(),
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/recycle',
              builder: (context, state) => const RecyclePage(),
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
              routes: [
                GoRoute(
                  path: 'account',
                  builder: (context, state) => const AccountPage(),
                ),
                GoRoute(
                  path: 'localization',
                  builder: (context, state) => const LocalizationPage(),
                ),
                GoRoute(
                  path: 'history',
                  builder: (context, state) => const HistoryPage(),
                ),
                GoRoute(
                  path: 'knowledge-base',
                  builder: (context, state) => const KnowledgeBasePage(),
                  routes: [
                    GoRoute(
                      path: 'knowledge-detail',
                      builder: (context, state) => const KnowledgeDetailPage(),
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
);
