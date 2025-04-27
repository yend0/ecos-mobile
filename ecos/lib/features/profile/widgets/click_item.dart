import 'package:flutter/material.dart';

class ClickItem {
  const ClickItem({
    required this.name,
    required this.onTap,
  });

  final String name;
  final VoidCallback onTap;
}
