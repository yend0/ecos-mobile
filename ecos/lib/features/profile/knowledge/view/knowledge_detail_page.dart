import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:ecos/clients/models/waste.dart';
import 'package:ecos/features/profile/profile.dart';
import 'package:ecos/router/route_utils.dart';

class KnowledgeDetailPage extends StatelessWidget {
  const KnowledgeDetailPage({
    super.key,
    required this.waste,
  });

  final Waste waste;

  @override
  Widget build(BuildContext context) {
    final lines = waste.wasteTranslations[0].description.trim().split('\n');
    lines.removeWhere((line) => line.isEmpty);
    final intro = lines.isNotEmpty ? lines.first : '';
    final bullets = lines.length > 1 ? lines.sublist(1) : [];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          TitleAppBar(
            text: waste.abbreviatedName,
            onPressed: () => context.go(
                '${PAGES.profile.screenPath}/${PAGES.knowledgeBase.screenPath}'),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 2,
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            waste.imageUrl,
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
                                waste.wasteTranslations[0].name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                waste.abbreviatedName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: Colors.grey.shade600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (intro.isNotEmpty)
                      Text(
                        intro,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    if (bullets.isNotEmpty) const SizedBox(height: 12),
                    ...bullets.map(
                      (line) => Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('• ', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                line.trim(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
