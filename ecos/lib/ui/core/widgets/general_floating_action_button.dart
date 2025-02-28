import 'package:flutter/material.dart';

class GeneralFloatingActionButton extends StatelessWidget {
  const GeneralFloatingActionButton({
    super.key,
    required this.theme,
    required this.text,
    required this.onPressed,
  });

  final ThemeData theme;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56.0,
        child: FloatingActionButton.extended(
          label: Text(
            text,
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: theme.primaryColor,
            ),
          ),
          foregroundColor: theme.primaryColor,
          backgroundColor: Colors.black,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
