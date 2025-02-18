import 'package:easy_localization/easy_localization.dart';
import 'package:ecos/features/home/home.dart';
import 'package:flutter/material.dart';

import 'package:ecos/ui/ui.dart';

import 'package:ecos/generated/generated.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          '${LocaleKeys.title_hello.tr()} Вадим',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.0),
                CardPoints(theme: theme),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    FeatureCard(
                      text:
                          LocaleKeys.feature_card_description_find_bucket.tr(),
                      onTap: () => {},
                      icon: Icons.pin_drop,
                    ),
                    SizedBox(width: 16.0),
                    FeatureCard(
                      text: LocaleKeys.feature_card_description_add_bucket.tr(),
                      onTap: () => {},
                      icon: Icons.public,
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                TitleDescription(
                  text: LocaleKeys.title_description_last_contribution.tr(),
                  textStyle: TextStyle(
                    fontFamily: 'Outfit',
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 16.0),
                HistoryList(
                  historyTiles: [
                    HistoryTile(
                      text: 'Апрель',
                      points: 10,
                      dateTime: TimeOfDay.now().format(context),
                    ),
                    HistoryTile(
                      text: 'Апрель',
                      points: 50,
                      dateTime: TimeOfDay.now().format(context),
                    ),
                    HistoryTile(
                      text: 'Апрель',
                      points: 70,
                      dateTime: TimeOfDay.now().format(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
