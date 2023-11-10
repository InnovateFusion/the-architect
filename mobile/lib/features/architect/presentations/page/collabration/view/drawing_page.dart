import 'dart:async';
import 'dart:convert';

import 'package:architect/features/architect/presentations/page/collabration/start.dart';
import 'package:architect/features/architect/presentations/page/collabration/view/drawing_canvas/drawing_canvas.dart';
import 'package:architect/features/architect/presentations/page/collabration/view/drawing_canvas/models/drawing_mode.dart';
import 'package:architect/features/architect/presentations/page/collabration/view/drawing_canvas/models/sketch.dart';
import 'package:architect/features/architect/presentations/page/collabration/view/drawing_canvas/widgets/canvas_side_bar.dart';
import 'package:architect/features/architect/presentations/page/collabration/view/drawing_canvas/widgets/chat.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Chat {
  final String message;
  final User user;

  Chat({required this.message, required this.user});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': user.toJson(),
    };
  }

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }
}

class DrawingPage extends HookWidget {
  DrawingPage({
    Key? key,
    required this.user,
    required this.boardId,
  }) : super(key: key);

  final User user;
  final String boardId;
  final allChatStream = StreamController<String>();

  final IO.Socket socket = IO.io(
    'https://sketch-dq5zwrwm5q-ww.a.run.app',
    IO.OptionBuilder().setTransports(['websocket']).build(),
  )..connect();

  @override
  Widget build(BuildContext context) {
    socket.onConnect((_) {
      print('connect');
    });

    final selectedColor = useState(Colors.black);
    final strokeSize = useState<double>(10);
    final eraserSize = useState<double>(30);
    final drawingMode = useState(DrawingMode.pencil);
    final filled = useState<bool>(false);
    final polygonSides = useState<int>(3);
    final canvasGlobalKey = GlobalKey();
    ValueNotifier<Sketch?> currentSketch = useState(null);
    ValueNotifier<List<Sketch>> allSketches = useState([]);
    ValueNotifier<List<Chat>> allChat = useState([]);

    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 100),
      initialValue: 1,
    );

    useEffect(() {
      socket.on('allSketches', (data) {
        allSketches.value = (jsonDecode(data) as List)
            .map((json) => Sketch.fromJson(json as Map<String, dynamic>))
            .toList();
      });

      socket.on('allChat', (data) {
        allChat.value = (jsonDecode(data) as List)
            .map((json) => Chat.fromJson(json as Map<String, dynamic>))
            .toList();
      });

      return () {
        allChatStream.close();
        animationController.dispose();
        allSketches.dispose();
        currentSketch.dispose();
        eraserSize.dispose();
        filled.dispose();
        polygonSides.dispose();
        selectedColor.dispose();
        strokeSize.dispose();
        drawingMode.dispose();
        socket.disconnect();
      };
    }, []);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: kCanvasColor,
              width: double.maxFinite,
              height: double.maxFinite,
              child: DrawingCanvas(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                boardId: boardId,
                drawingMode: drawingMode,
                selectedColor: selectedColor,
                strokeSize: strokeSize,
                eraserSize: eraserSize,
                currentSketch: currentSketch,
                allSketches: allSketches,
                canvasGlobalKey: canvasGlobalKey,
                filled: filled,
                polygonSides: polygonSides,
              ),
            ),
            Positioned(
              left: 10,
              top: 0,
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(5)),
                height: 50,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xff22c55e),
                          borderRadius: BorderRadius.circular(5)),
                      height: 40,
                      width: 40,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Share",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Sketch",
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 86,
              left: 0,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(animationController),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0),
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
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: ChatDisplay(
                id: boardId,
                user: user,
                allChat: allChat,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
