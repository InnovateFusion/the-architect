import 'dart:ui';

import 'package:architect/page/drawing/drawing.dart';
import 'package:architect/page/drawing/view/drawing_canvas/drawing_canvas.dart';
import 'package:architect/page/drawing/view/drawing_canvas/models/drawing_mode.dart';
import 'package:architect/page/drawing/view/drawing_canvas/models/sketch.dart';
import 'package:flutter/material.dart' hide Image;

import 'package:flutter_hooks/flutter_hooks.dart';

import 'drawing_canvas/widgets/canvas_side_bar.dart';

class DrawingPage extends HookWidget {
  const DrawingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final backgroundImage = useState<Image?>(null);

    final canvasGlobalKey = GlobalKey();

    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: kCanvasColor,
              width: double.maxFinite,
              height: double.maxFinite,
              child: DrawingCanvas(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                drawingMode: drawingMode,
                selectedColor: selectedColor,
                strokeSize: strokeSize,
                eraserSize: eraserSize,
                currentSketch: currentSketch,
                allSketches: allSketches,
                canvasGlobalKey: canvasGlobalKey,
                filled: filled,
                polygonSides: polygonSides,
                backgroundImage: backgroundImage,
              ),
            ),
            Positioned(
                left: 10,
                top: 15,
                child: Container(
                    width: 40,
                    height: 40,
                    padding: const EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB5B2B3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: IconButton(
                        iconSize: 25,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                    ))),
            Positioned(
              top: kToolbarHeight + 60,
              left: 5,
              child: CanvasSideBar(
                drawingMode: drawingMode,
                selectedColor: selectedColor,
                strokeSize: strokeSize,
                eraserSize: eraserSize,
                currentSketch: currentSketch,
                allSketches: allSketches,
                canvasGlobalKey: canvasGlobalKey,
                filled: filled,
                polygonSides: polygonSides,
                backgroundImage: backgroundImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
