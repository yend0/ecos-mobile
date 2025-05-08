import 'package:flutter/material.dart';

class BaseError extends StatelessWidget {
  const BaseError({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text(
              'Что-то пошло не так...',
              style: theme.textTheme.bodyLarge,
            ),
            Text(
              'Пожалуйста, повторите попытку позже',
              style: theme.textTheme.labelMedium,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: Text('Повторить попытку',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  )),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
