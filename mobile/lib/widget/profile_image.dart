import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  final double size;

  const ProfileImage({
    Key? key,
    required this.imageUrl,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
