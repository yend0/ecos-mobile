import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ecos/generated/generated.dart';

class RootPage extends StatelessWidget {
  const RootPage({
    super.key,
    required this.navigationShell,
  });

  static const String _homeIcon = 'assets/icons/ic_home.svg';
  static const String _profileIcon = 'assets/icons/ic_profile.svg';

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedLabelStyle: theme.textTheme.bodySmall,
        unselectedLabelStyle: theme.textTheme.bodySmall,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        currentIndex: navigationShell.currentIndex,
        items: _buildBottomNavBarItems(theme),
        onTap: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _buildBottomNavBarItems(ThemeData theme) => [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            RootPage._homeIcon,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(theme.disabledColor, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            RootPage._homeIcon,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          label: LocaleKeys.root_label_home,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.recycling_rounded,
            size: 24,
            color: theme.disabledColor,
          ),
          activeIcon: Icon(
            Icons.recycling_rounded,
            size: 24,
          ),
          label: LocaleKeys.root_label_recycle,
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            RootPage._profileIcon,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(theme.disabledColor, BlendMode.srcIn),
          ),
          activeIcon: SvgPicture.asset(
            RootPage._profileIcon,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          label: LocaleKeys.root_label_profile,
        ),
      ];
}
