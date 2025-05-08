import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:go_router/go_router.dart';

import 'package:ecos/ui/ui.dart';
import 'package:ecos/router/router.dart';
import 'package:ecos/features/profile/profile.dart';

import 'package:ecos/generated/generated.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const String _historyIcon = 'assets/icons/ic_history.svg';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(const ProfileRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {},
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingFailureState) {
            return BaseError(
              onPressed: () async {
                final profileBloc = BlocProvider.of<ProfileBloc>(context);
                final complete = Completer();

                profileBloc.add(ProfileRequestEvent(completer: complete));
                await complete.future;
              },
            );
          }
          if (state is ProfileLoadingSuccessState) {
            final user = state.user;
            List<ClickItem> settings = [
              ClickItem(
                name: LocaleKeys.buttons_route_account.tr(),
                onTap: () => context.go(
                  '${PAGES.profile.screenPath}/${PAGES.account.screenPath}',
                  extra: user,
                ),
              ),
              ClickItem(
                name: LocaleKeys.buttons_route_languages.tr(),
                onTap: () => context.go(
                    '${PAGES.profile.screenPath}/${PAGES.localization.screenPath}'),
              ),
            ];
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            LogoutIconButton(),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 28.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 28.0),
                            Align(
                              alignment: Alignment.topCenter,
                              child: AvatarCircle(
                                imageUrl: user.imageUrl,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              user.email,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Expanded(
                            child: FeatureCard(
                              text: LocaleKeys.feature_card_description_history
                                  .tr(),
                              onTap: () => context.go(
                                '${PAGES.profile.screenPath}/${PAGES.history.screenPath}',
                                extra: user.accuralHistories,
                              ),
                              svgAsset: ProfilePage._historyIcon,
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            child: FeatureCard(
                              text: LocaleKeys
                                  .feature_card_description_reference_information
                                  .tr(),
                              onTap: () => context.go(
                                  '${PAGES.profile.screenPath}/${PAGES.knowledgeBase.screenPath}'),
                              icon: Icons.compost,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 16.0),
                    ),
                    SliverToBoxAdapter(
                      child: TitleDescription(
                        text: LocaleKeys.title_description_settings.tr(),
                        textStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 8.0),
                    ),
                    SliverToBoxAdapter(
                      child: ClickListContainer(
                        items: settings,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 24.0),
                    ),
                    SliverToBoxAdapter(
                      child: TitleDescription(
                        text: LocaleKeys.title_description_help.tr(),
                        textStyle: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: 8.0),
                    ),
                    SliverToBoxAdapter(
                      child: ClickListContainer(
                        items: [
                          ClickItem(
                            name: LocaleKeys.buttons_route_faq.tr(),
                            onTap: () => context.go(PAGES.profile.screenPath),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const LoadingCenterProgress();
        },
      ),
    );
  }
}
