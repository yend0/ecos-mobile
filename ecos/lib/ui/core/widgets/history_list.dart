import 'package:flutter/material.dart';

import 'package:ecos/ui/ui.dart';

class HistoryList extends StatelessWidget {
  const HistoryList({
    super.key,
    required this.historyTiles,
  });

  final List<HistoryTile> historyTiles;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8.0),
        itemCount: historyTiles.length,
        separatorBuilder: (context, index) => Divider(
          indent: 16.0,
          height: 1.0,
          color: Colors.grey[300],
        ),
        itemBuilder: (context, index) => historyTiles[index],
      ),
    );
  }
}
