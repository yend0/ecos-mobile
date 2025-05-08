import 'package:flutter/material.dart';

class LoadingCenterProgress extends StatelessWidget {
  const LoadingCenterProgress({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: const Color(0xFF25884F),
        ),
      ),
    );
  }
}
