import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:ecos/ui/ui.dart';
import 'package:ecos/generated/generated.dart';
import 'package:ecos/features/recycle/recycle.dart';

class RecyclePage extends StatefulWidget {
  const RecyclePage({super.key});

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<RecycleBloc>(context).add(const RecycleRequestEvent());
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<RecycleBloc, RecycleState>(
      builder: (context, state) {
        if (state is RecycleLoadingSuccessState) {
          final featureCards = state.wastes;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              centerTitle: true,
              title: Text(
                LocaleKeys.root_label_recycle.tr(),
                style: theme.textTheme.titleMedium,
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.all(16.0),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => WasteCard(
                        name: featureCards[index].wasteTranslations[index].name,
                        abbreviatedName: featureCards[index].abbreviatedName,
                        onTap: () {},
                        icon: featureCards[index].imageUrl,
                      ),
                      childCount: featureCards.length,
                    ),
                  ),
                )
              ],
            ),
          );
        } else if (state is RecycleLoadingFailureState) {
          return BaseError(
            onPressed: () async {
              final recycleBloc = BlocProvider.of<RecycleBloc>(context);
              final complete = Completer();

              recycleBloc.add(RecycleRequestEvent(completer: complete));
              await complete.future;
            },
          );
        }
        return LoadingCenterProgress();
      },
    );
  }
}

class WasteCard extends StatelessWidget {
  const WasteCard({
    super.key,
    required this.abbreviatedName,
    required this.name,
    required this.onTap,
    required this.icon,
  });

  final String abbreviatedName;
  final String name;
  final VoidCallback onTap;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                icon,
                height: 48,
                width: 48,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.image_not_supported,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    abbreviatedName,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
