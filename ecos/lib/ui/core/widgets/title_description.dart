import 'package:flutter/material.dart';

class TitleDescription extends StatelessWidget {
  const TitleDescription({
    super.key,
    required this.text,
    required this.textStyle,
  });

  final String text;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Text(
        text,
        style: textStyle,
      ),
    );
  }
}
