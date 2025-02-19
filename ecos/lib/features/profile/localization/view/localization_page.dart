import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:go_router/go_router.dart';

import 'package:ecos/features/profile/profile.dart';

import 'package:ecos/generated/generated.dart';

class LocalizationPage extends StatefulWidget {
  const LocalizationPage({super.key});

  @override
  State<LocalizationPage> createState() => _LocalizationPageState();
}

class _LocalizationPageState extends State<LocalizationPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var selectedLanguage = context.locale.toString();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TitleAppBar(
            text: LocaleKeys.buttons_languages.tr(),
            onPressed: () => context.go('/profile'),
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RadioListTile(
                    title: Text(
                      'Русский',
                      style: theme.textTheme.titleMedium,
                    ),
                    value: 'ru_RU',
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        context.setLocale(Locale('ru', 'RU'));
                        selectedLanguage = context.locale.toString();
                      });
                    }),
                RadioListTile(
                    title: Text(
                      'English',
                      style: theme.textTheme.titleMedium,
                    ),
                    value: 'en_US',
                    groupValue: selectedLanguage,
                    onChanged: (value) {
                      setState(() {
                        context.setLocale(Locale('en', 'US'));
                        selectedLanguage = context.locale.toString();
                      });
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
