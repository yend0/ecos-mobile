import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:ecos/ui/core/core.dart';
import 'package:ecos/clients/clients.dart';
import 'package:ecos/router/router.dart';

import 'package:ecos/features/auth/auth.dart';

class EcosApp extends StatefulWidget {
  const EcosApp({super.key});

  @override
  State<EcosApp> createState() => _EcosAppState();
}

class _EcosAppState extends State<EcosApp> {
  late final FlutterSecureStorage _storage;
  late final AuthClient _authClient;
  late final Talker _talker;
  @override
  void initState() {
    super.initState();

    _storage = const FlutterSecureStorage();
    _authClient = AuthClient.create(ssoUrl: dotenv.env['SSO_PATH']);
    _talker = TalkerFlutter.init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            storage: _storage,
            authClient: _authClient,
            clientId: dotenv.env['CLIENT_ID']!,
            grantTypes: {
              'password': 'password',
              'refresh_token': 'refresh_token'
            },
            logger: _talker,
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Ecos',
        theme: LightTheme.lightTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routeInformationProvider: AppRouter.router.routeInformationProvider,
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
      ),
    );
  }
}
