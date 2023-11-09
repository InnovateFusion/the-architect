import 'package:flutter/material.dart';

import '../../../domains/entities/user.dart';
import 'view/drawing_page.dart';

const Color kCanvasColor = Color.fromARGB(255, 236, 238, 244);

class Draw extends StatelessWidget {
  final User user;
  final bool fromChat;

  const Draw({
    Key? key,
    required this.user,
    this.fromChat = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawingPage(user: user, fromChat: fromChat);
  }
}
