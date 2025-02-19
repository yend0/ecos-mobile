import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:ecos/features/profile/profile.dart';

import 'package:ecos/generated/generated.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TitleAppBar(
            text: LocaleKeys.buttons_account.tr(),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
    );
  }
}
