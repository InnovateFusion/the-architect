import 'package:architect/features/architect/presentations/page/collabration/view/drawing_page.dart';
import 'package:flutter/material.dart';

import '../../../domains/entities/user.dart' as x_user;

class User {
  final String name;
  final String image;

  User({required this.name, required this.image});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      image: json['image'],
    );
  }
}

const Color kCanvasColor = Color.fromARGB(255, 236, 238, 244);

class CollabDrawing extends StatelessWidget {
  final x_user.User user;
  final String image;

  const CollabDrawing({super.key, required this.user, required this.image});

  @override
  Widget build(BuildContext context) {
    return DrawingPage(
      user: User(name: user.firstName, image: image),
      boardId: 'cxcccc',
    );
  }
}
