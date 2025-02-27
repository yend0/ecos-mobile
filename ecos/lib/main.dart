import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ecos/ecos_app.dart';
import 'package:ecos/ui/ui.dart';

import 'package:ecos/generated/generated.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  await dotenv.load(fileName: '.env');

  runApp(
    EasyLocalization(
      supportedLocales: L10n.supportedLocales,
      path: L10n.pathToLocalization,
      fallbackLocale: L10n.fallbackLocale,
      assetLoader: CodegenLoader(),
      child: const EcosApp(),
    ),
  );
}
