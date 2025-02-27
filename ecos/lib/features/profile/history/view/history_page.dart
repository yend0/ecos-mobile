import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos/ui/ui.dart';
import 'package:ecos/features/profile/profile.dart';

import 'package:ecos/generated/generated.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TitleAppBar(
            text: LocaleKeys.feature_card_description_history.tr(),
            onPressed: () => context.go('/profile'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: HistoryList(
                historyTiles: [
                  HistoryTile(
                    text: 'Добавлен пункт',
                    points: 10,
                    dateTime: '06/04/2024 - 7:03',
                  ),
                  HistoryTile(
                    text: 'Добавлен пункт',
                    points: 50,
                    dateTime: '06/04/2024 - 7:03',
                  ),
                  HistoryTile(
                    text: 'Добавлен пункт',
                    points: 70,
                    dateTime: '06/04/2024 - 7:03',
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
