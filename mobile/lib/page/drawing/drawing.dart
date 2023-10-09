import 'package:architect/page/drawing/view/drawing_page.dart';
import 'package:flutter/material.dart';

const Color kCanvasColor = Color.fromARGB(255, 255, 255, 255);

class Draw extends StatelessWidget {
  const Draw({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const DrawingPage();
  }
}
