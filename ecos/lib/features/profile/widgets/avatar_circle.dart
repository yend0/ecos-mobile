import 'package:flutter/material.dart';

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({
    super.key,
    this.imageUrl,
    this.radius = 50.0,
  });

  static const Color _color = Color(0xFF25884F);

  final String? imageUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.black,
          width: 0.7,
        ),
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundImage: imageUrl != null && imageUrl!.isNotEmpty
            ? NetworkImage(imageUrl!)
            : null,
        backgroundColor: imageUrl == null || imageUrl!.isEmpty ? _color : null,
      ),
    );
  }
}
