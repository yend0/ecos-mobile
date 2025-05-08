import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:ecos/router/router.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/generated/generated.dart';
import 'package:ecos/clients/clients.dart';
import 'package:ecos/ui/core/core.dart';

class KnowledgeBasePage extends StatefulWidget {
  const KnowledgeBasePage({super.key});

  @override
  State<KnowledgeBasePage> createState() => _KnowledgeBasePageState();
}

class _KnowledgeBasePageState extends State<KnowledgeBasePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<KnowledgeBloc>(context).add(const KnowledgeRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<KnowledgeBloc, KnowledgeState>(
      builder: (context, state) {
        if (state is KnowledgeLoadingSuccessState) {
          final List<Waste> wastes = state.wastes;

          if (wastes.isEmpty) {
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  TitleAppBar(
                    text: LocaleKeys
                        .feature_card_description_reference_information
                        .tr(),
                    onPressed: () => context.go(PAGES.profile.screenPath),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text(
                          'База знаний пуста...',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Scaffold(
            body: CustomScrollView(slivers: [
              TitleAppBar(
                text: LocaleKeys.feature_card_description_reference_information
                    .tr(),
                onPressed: () => context.go(PAGES.profile.screenPath),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ClickListContainer(
                      items: wastes
                          .map(
                            (waste) => ClickItem(
                              name: waste.abbreviatedName,
                              onTap: () {
                                context.go(
                                  '${PAGES.profile.screenPath}/${PAGES.knowledgeBase.screenPath}/${PAGES.knowledgeDetail.screenPath}',
                                  extra: waste,
                                );
                              },
                            ),
                          )
                          .toList()),
                ),
              ),
            ]),
          );
        } else if (state is KnowledgeLoadingFailureState) {
          return BaseError(
            onPressed: () async {
              final knowledgeBloc = BlocProvider.of<KnowledgeBloc>(context);
              final complete = Completer();

              knowledgeBloc.add(KnowledgeRequestEvent(completer: complete));
              await complete.future;
            },
          );
        }
        return LoadingCenterProgress();
      },
    );
  }
}
