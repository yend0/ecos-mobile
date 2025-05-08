import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos/ui/ui.dart';
import 'package:ecos/router/router.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/clients/clients.dart';

import 'package:ecos/generated/generated.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({
    super.key,
    required this.accrualHistories,
  });

  final List<AccuralHistory> accrualHistories;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TitleAppBar(
            text: LocaleKeys.feature_card_description_history.tr(),
            onPressed: () => context.go(PAGES.profile.screenPath),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: HistoryList(
                  historyTiles: accrualHistories
                      .map((history) => HistoryTile(
                            text: history.reward,
                            points: history.points,
                            dateTime: _formatDateTime(history.created),
                          ))
                      .toList()),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return "--/--/---- - --:--";

    final dateFormat = DateFormat('dd/MM/yyyy - H:mm');
    return dateFormat.format(dateTime);
  }
}
