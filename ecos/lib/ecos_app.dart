import 'package:easy_localization/easy_localization.dart';
import 'package:ecos/router/router.dart';
import 'package:ecos/ui/core/themes/themes.dart';
import 'package:flutter/material.dart';

class EcosApp extends StatelessWidget {
  const EcosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ecos',
      theme: LightTheme.lightTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: router,
    );
  }
}
