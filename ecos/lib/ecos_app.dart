import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'package:ecos/ui/core/core.dart';
import 'package:ecos/clients/clients.dart';
import 'package:ecos/router/router.dart';

import 'package:ecos/features/auth/auth.dart';
import 'package:ecos/features/home/home.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/features/recycle/recycle.dart';

class EcosApp extends StatefulWidget {
  const EcosApp({super.key});

  @override
  State<EcosApp> createState() => _EcosAppState();
}

class _EcosAppState extends State<EcosApp> {
  late final FlutterSecureStorage _storage;
  late final AuthClient _authClient;
  late final UserClient _userClient;
  late final WasteClient _wasteClient;
  late final Talker _talker;
  @override
  void initState() {
    super.initState();

    _storage = const FlutterSecureStorage();
    _authClient = AuthClient.create(ssoUrl: dotenv.env['SSO_URL']);
    _userClient = UserClient.create(apiUrl: dotenv.env['API_URL']);
    _wasteClient = WasteClient.create(apiUrl: dotenv.env['API_URL']);
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
        BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(
            userClient: _userClient,
            logger: _talker,
          ),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            storage: _storage,
            userClient: _userClient,
            logger: _talker,
          ),
        ),
        BlocProvider<AccountBloc>(
          create: (context) => AccountBloc(
            storage: _storage,
            userClient: _userClient,
            logger: _talker,
          ),
        ),
        BlocProvider<KnowledgeBloc>(
          create: (context) => KnowledgeBloc(
            wasteClient: _wasteClient,
            logger: _talker,
          ),
        ),
        BlocProvider<RecycleBloc>(
          create: (context) => RecycleBloc(
            wasteClient: _wasteClient,
            logger: _talker,
          ),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(
            storage: _storage,
            userClient: _userClient,
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
