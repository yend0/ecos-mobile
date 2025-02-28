import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HelpText extends StatelessWidget {
  const HelpText({
    super.key,
    required this.onPressed,
    required this.questionText,
    required this.actionText,
  });

  final VoidCallback onPressed;
  final String questionText;
  final String actionText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: questionText,
        style: const TextStyle(color: Colors.black, fontSize: 14),
        children: [
          TextSpan(
            text: actionText,
            style: const TextStyle(color: Colors.blue, fontSize: 14),
            recognizer: TapGestureRecognizer()..onTap = onPressed,
          ),
        ],
      ),
    );
  }
}
