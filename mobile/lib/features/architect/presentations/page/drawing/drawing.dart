import 'package:flutter/material.dart';

import '../../../domains/entities/user.dart';
import 'view/drawing_page.dart';

const Color kCanvasColor = Color.fromARGB(255, 255, 255, 255);

class Draw extends StatelessWidget {
  final User user;
  final bool fromChat;

  const Draw({
    Key? key,
    required this.user,
    this.fromChat = false,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DrawingPage(user: user, fromChat: fromChat);
  }
}
