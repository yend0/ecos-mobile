
import 'package:ecos/theme/theme.dart';
import 'package:flutter/material.dart';

import 'features/home/home.dart';

class EcosApp extends StatelessWidget {
  const EcosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecos',
      theme: EcosAppTheme.lightTheme,
      home: HomePage(),
    );
  }
}