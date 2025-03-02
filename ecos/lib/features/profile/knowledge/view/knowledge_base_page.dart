import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ecos/router/router.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/generated/generated.dart';

class KnowledgeBasePage extends StatelessWidget {
  const KnowledgeBasePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ClickItem> knowledgeList = [
      ClickItem(
        title: 'Бумага',
        path: '/profile/knowledge-base/knowledge-detail',
      ),
      ClickItem(
        title: 'Стекло',
        path: '/profile/knowledge-base/knowledge-detail',
      ),
      ClickItem(
        title: 'Пластик',
        path: '/profile/knowledge-base/knowledge-detail',
      ),
      ClickItem(
        title: 'Пищевые отходы',
        path: '/profile/knowledge-base/knowledge-detail',
      ),
    ];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TitleAppBar(
            text: LocaleKeys.feature_card_description_knowledge_base.tr(),
            onPressed: () => context.go(PAGES.profile.screenPath),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClickListContainer(
                items: knowledgeList,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
