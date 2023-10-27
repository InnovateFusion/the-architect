import 'package:flutter/material.dart';

import '../../domains/entities/user.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;
  final double size;
  final User? user;

  const ProfileImage({
    Key? key,
    this.user,
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
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
