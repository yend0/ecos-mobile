import 'package:ecos/ui/ui.dart';
import 'package:flutter/material.dart';

import 'package:ecos/features/profile/profile.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String _historyIcon = 'assets/icons/ic_history.svg';

  static List<ClickItem> settings = [
    ClickItem(
      title: 'Ваша учетная запись',
      path: '/profile/account',
    ),
    ClickItem(
      title: 'Языки',
      path: '/profile',
    ),
  ];

  static List<ClickItem> helps = [
    ClickItem(
      title: 'FAQ',
      path: '/profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 28.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 28.0),
                    Align(
                      alignment: Alignment.topCenter,
                      child: AvatarCircle(),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Вадим Р.',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                children: [
                  FeatureCard(
                    text: 'История',
                    onTap: () => context.go('/profile/history'),
                    svgAsset: _historyIcon,
                  ),
                  SizedBox(width: 16.0),
                  FeatureCard(
                    text: 'База знаний',
                    onTap: () => context.go('/profile/knowledge-base'),
                    icon: Icons.compost,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 16.0),
            ),
            SliverToBoxAdapter(
              child: TitleDescription(
                text: 'Настройки',
                textStyle: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 8.0),
            ),
            SliverToBoxAdapter(
              child: ClickListContainer(
                items: settings,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 24.0),
            ),
            SliverToBoxAdapter(
              child: TitleDescription(
                text: 'Помощь и поддержка',
                textStyle: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 8.0),
            ),
            SliverToBoxAdapter(
              child: ClickListContainer(
                items: helps,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
