import 'package:flutter/material.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
    required this.text,
    required this.points,
    required this.dateTime,
  });

  final String text;
  final String dateTime;
  final int points;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(
        text,
        style: theme.textTheme.titleMedium,
      ),
      subtitle: Text(
        dateTime,
        style: theme.textTheme.bodyMedium,
      ),
      trailing: Text(
        '$points бал.',
        style: TextStyle(
          fontFamily: 'Outfit',
          color: Colors.green,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
