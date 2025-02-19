import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos/ui/ui.dart';
import 'package:ecos/features/profile/profile.dart';

import 'package:ecos/generated/generated.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String _historyIcon = 'assets/icons/ic_history.svg';

  static List<ClickItem> helps = [
    ClickItem(
      title: LocaleKeys.buttons_faq.tr(),
      path: '/profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<ClickItem> settings = [
      ClickItem(
        title: LocaleKeys.buttons_account.tr(),
        path: '/profile/account',
      ),
      ClickItem(
        title: LocaleKeys.buttons_languages.tr(),
        path: '/profile/localization',
      ),
    ];
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
                    text: LocaleKeys.feature_card_description_history.tr(),
                    onTap: () => context.go('/profile/history'),
                    svgAsset: _historyIcon,
                  ),
                  SizedBox(width: 16.0),
                  FeatureCard(
                    text:
                        LocaleKeys.feature_card_description_knowledge_base.tr(),
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
                text: LocaleKeys.title_description_settings.tr(),
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
                text: LocaleKeys.title_description_help.tr(),
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
