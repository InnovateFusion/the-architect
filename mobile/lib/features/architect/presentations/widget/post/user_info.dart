import 'package:flutter/material.dart';

import '../../../domains/entities/user.dart';
import '../profile_image.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final String date;
  final String imageUrl;
  final String id;
  final User user;

  const UserInfo({
    Key? key,
    required this.user,
    required this.id,
    required this.name,
    required this.date,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 50,
      decoration: const BoxDecoration(
        color: Color(0x99000000),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 4),
          CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: ProfileImage(imageUrl: imageUrl, size: 50)),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 7),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 8,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
