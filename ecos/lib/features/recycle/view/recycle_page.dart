import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ecos/ui/ui.dart';
import 'package:ecos/generated/generated.dart';

class RecyclePage extends StatelessWidget {
  const RecyclePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<FeatureCard> featureCards = [
      FeatureCard(
        text: 'Бумага',
        onTap: () => {},
        icon: Icons.book,
      ),
      FeatureCard(
        text: 'Стекло',
        onTap: () => {},
        icon: Icons.book,
      ),
      FeatureCard(
        text: 'Пищевые отходы',
        onTap: () => {},
        icon: Icons.book,
      ),
      FeatureCard(
        text: 'Пластик',
        onTap: () => {},
        icon: Icons.book,
      ),
      FeatureCard(
        text: 'Металл',
        onTap: () => {},
        icon: Icons.book,
      ),
      FeatureCard(
        text: 'Одежда',
        onTap: () => {},
        icon: Icons.book,
      ),
      FeatureCard(
        text: 'Батарейки',
        onTap: () => {},
        icon: Icons.book,
      ),
      FeatureCard(
        text: 'Техника',
        onTap: () => {},
        icon: Icons.book,
      ),
      FeatureCard(
        text: 'Опасное',
        onTap: () => {},
        icon: Icons.book,
      ),
      FeatureCard(
        text: 'Другое',
        onTap: () => {},
        icon: Icons.book,
      ),
    ];

    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          LocaleKeys.root_label_recycle.tr(),
          style: theme.textTheme.titleMedium,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: EdgeInsets.all(16.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) => FeatureCard(
                  text: featureCards[index].text,
                  onTap: featureCards[index].onTap,
                  icon: featureCards[index].icon,
                ),
                childCount: featureCards.length,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.5),
            ),
          )
        ],
      ),
    );
  }
}
