import 'package:easy_localization/easy_localization.dart';
import 'package:ecos/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    BlocProvider.of<HomeBloc>(context).add(const HomeRequestEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingFailureState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.title_hello.tr(),
                style: theme.textTheme.titleLarge,
              ),
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
            ),
            body: RefreshIndicator(
              color: const Color(0xFF25884F),
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
                      CardPoints(
                        theme: theme,
                        points: 0,
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: FeatureCard(
                              text: LocaleKeys
                                  .feature_card_description_find_bucket
                                  .tr(),
                              onTap: () => {},
                              icon: Icons.pin_drop,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: FeatureCard(
                              text: LocaleKeys
                                  .feature_card_description_add_bucket
                                  .tr(),
                              onTap: () => {},
                              icon: Icons.public,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      TitleDescription(
                        text:
                            LocaleKeys.title_description_last_contribution.tr(),
                        textStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.info_outline,
                              size: 48.0,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              ' LocaleKeys.info_register_to_contribute.tr(),',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else if (state is HomeLoadingSuccessState) {
          final accrualHistories = state.user.accuralHistories;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              title: Text(
                LocaleKeys.title_hello.tr(),
                style: theme.textTheme.titleLarge,
              ),
            ),
            body: RefreshIndicator(
              color: const Color(0xFF25884F),
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
                      CardPoints(
                        theme: theme,
                        points: state.user.points,
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        children: [
                          Expanded(
                            child: FeatureCard(
                              text: LocaleKeys
                                  .feature_card_description_find_bucket
                                  .tr(),
                              onTap: () => {},
                              icon: Icons.pin_drop,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: FeatureCard(
                              text: LocaleKeys
                                  .feature_card_description_add_bucket
                                  .tr(),
                              onTap: () => {},
                              icon: Icons.public,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.0),
                      TitleDescription(
                        text:
                            LocaleKeys.title_description_last_contribution.tr(),
                        textStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      HistoryList(historyTiles: [
                        for (var accrualHistory in accrualHistories!.take(3))
                          HistoryTile(
                            text: accrualHistory.reward,
                            points: accrualHistory.points,
                            dateTime: DateFormat('dd/MM/yyyy - HH:mm')
                                .format(accrualHistory.created),
                          ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.scaffoldBackgroundColor,
            elevation: 0,
          ),
          body: Center(
            child: CircularProgressIndicator(
              color: const Color(0xFF25884F),
            ),
          ),
        );
      },
    );
  }
}
