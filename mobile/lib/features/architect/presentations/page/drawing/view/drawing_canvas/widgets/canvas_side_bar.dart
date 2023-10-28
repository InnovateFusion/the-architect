import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:architect/features/architect/presentations/page/chat.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../domains/entities/user.dart';
import '../models/drawing_mode.dart';
import '../models/sketch.dart';
import 'color_palette.dart';
import 'icon_box.dart';

class CanvasSideBar extends HookWidget {
  final ValueNotifier<Color> selectedColor;
  final ValueNotifier<double> strokeSize;
  final ValueNotifier<double> eraserSize;
  final ValueNotifier<DrawingMode> drawingMode;
  final ValueNotifier<Sketch?> currentSketch;
  final ValueNotifier<List<Sketch>> allSketches;
  final GlobalKey canvasGlobalKey;
  final ValueNotifier<bool> filled;
  final ValueNotifier<int> polygonSides;
  final ValueNotifier<ui.Image?> backgroundImage;
  final bool fromChat;
  final User user;

  const CanvasSideBar({
    Key? key,
    required this.fromChat,
    required this.user,
    required this.selectedColor,
    required this.strokeSize,
    required this.eraserSize,
    required this.drawingMode,
    required this.currentSketch,
    required this.allSketches,
    required this.canvasGlobalKey,
    required this.filled,
    required this.polygonSides,
    required this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final undoRedoStack = useState(_UndoRedoStack(
      sketchesNotifier: allSketches,
      currentSketchNotifier: currentSketch,
    ));
    return SizedBox(
      width: 60,
      height: MediaQuery.of(context).size.height < 680 ? 450 : 600,
      child: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconBox(
                iconData: FontAwesomeIcons.pencil,
                selected: drawingMode.value == DrawingMode.pencil,
                onTap: () => drawingMode.value = DrawingMode.pencil,
                tooltip: 'Pencil',
              ),
              IconBox(
                iconData: Icons.line_weight_outlined,
                selected: drawingMode.value == DrawingMode.line,
                onTap: () => drawingMode.value = DrawingMode.line,
                tooltip: 'Line',
              ),
              IconBox(
                iconData: Icons.hexagon_outlined,
                selected: drawingMode.value == DrawingMode.polygon,
                onTap: () => drawingMode.value = DrawingMode.polygon,
                tooltip: 'Polygon',
              ),
              IconBox(
                iconData: FontAwesomeIcons.eraser,
                selected: drawingMode.value == DrawingMode.eraser,
                onTap: () => drawingMode.value = DrawingMode.eraser,
                tooltip: 'Eraser',
              ),
              IconBox(
                iconData: FontAwesomeIcons.square,
                selected: drawingMode.value == DrawingMode.square,
                onTap: () => drawingMode.value = DrawingMode.square,
                tooltip: 'Square',
              ),
              IconBox(
                iconData: FontAwesomeIcons.circle,
                selected: drawingMode.value == DrawingMode.circle,
                onTap: () => drawingMode.value = DrawingMode.circle,
                tooltip: 'Circle',
              ),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: allSketches.value.isNotEmpty
                    ? () => undoRedoStack.value.undo()
                    : null,
                child: Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 181, 178, 179),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Icon(
                      Icons.undo_outlined,
                      color: Colors.grey[900],
                    )),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: undoRedoStack.value._canRedo,
                builder: (_, canRedo, __) {
                  return GestureDetector(
                    onTap: canRedo ? () => undoRedoStack.value.redo() : null,
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 181, 178, 179),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Icon(
                        Icons.redo_outlined,
                        color: canRedo ? Colors.white : Colors.grey[900],
                      ),
                    ),
                  );
                },
              ),
              GestureDetector(
                onTap: () => undoRedoStack.value.clear(),
                child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 181, 178, 179),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Icon(
                    Icons.cleaning_services_outlined,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (backgroundImage.value != null) {
                    backgroundImage.value = null;
                  } else {
                    backgroundImage.value = await _getImage;
                  }
                },
                child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 181, 178, 179),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: backgroundImage.value == null
                      ? Icon(
                          Icons.image_search_outlined,
                          color: Colors.grey[900],
                        )
                      : Icon(
                          Icons.delete_outline,
                          color: Colors.grey[900],
                        ),
                ),
              ),
              InkResponse(
                onTap: () {
                  filled.value = !filled.value;
                },
                child: Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: filled.value
                          ? const Color.fromARGB(255, 0, 0, 0)
                          : const Color.fromARGB(255, 150, 150, 150),
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: filled.value
                        ? const Icon(
                            Icons.check,
                            size: 20.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: PopupMenuButton(
                  icon: const Icon(Icons.color_lens_outlined),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: ValueListenableBuilder<Color>(
                          valueListenable: selectedColor,
                          builder: (context, color, _) {
                            return ColorPalette(selectedColor: selectedColor);
                          },
                        ),
                      ),
                    ];
                  },
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: PopupMenuButton(
                  icon: const Icon(Icons.polyline_outlined),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ValueListenableBuilder<double>(
                          valueListenable: ValueNotifier<double>(
                              polygonSides.value.toDouble()),
                          builder: (context, value, _) {
                            return Column(children: [
                              const Text(
                                'Polygon Side',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ui.Color.fromARGB(255, 6, 6, 6),
                                    fontWeight: FontWeight.w600),
                              ),
                              Slider(
                                value: polygonSides.value.toDouble(),
                                min: 3,
                                max: 8,
                                divisions: 5,
                                label: '${value.toInt()}',
                                activeColor:
                                    const ui.Color.fromARGB(255, 119, 116, 116),
                                inactiveColor:
                                    const ui.Color.fromARGB(255, 203, 198, 198),
                                onChanged: (val) {
                                  polygonSides.value = val.toInt();
                                },
                              ),
                            ]);
                          },
                        ),
                      ),
                    ];
                  },
                ),
              ),
              SizedBox(
                width: 40,
                height: 40,
                child: PopupMenuButton(
                  icon: const Icon(Icons.bubble_chart_outlined),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ValueListenableBuilder<double>(
                          valueListenable: strokeSize,
                          builder: (context, value, _) {
                            return Column(children: [
                              const Text(
                                'Stroke Size',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ui.Color.fromARGB(255, 6, 6, 6),
                                    fontWeight: FontWeight.w600),
                              ),
                              Slider(
                                value: value,
                                min: 0,
                                max: 50,
                                label: '${value.toInt()}',
                                activeColor:
                                    const Color.fromARGB(255, 119, 116, 116),
                                inactiveColor:
                                    const Color.fromARGB(255, 203, 198, 198),
                                onChanged: (val) {
                                  strokeSize.value = val;
                                },
                              ),
                            ]);
                          },
                        ),
                      ),
                    ];
                  },
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 40,
                height: 40,
                child: PopupMenuButton(
                  icon: const Icon(Icons.remove_circle_outline_outlined),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ValueListenableBuilder<double>(
                          valueListenable: eraserSize,
                          builder: (context, value, _) {
                            return Column(children: [
                              const Text(
                                'Eraser Size',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: ui.Color.fromARGB(255, 6, 6, 6),
                                    fontWeight: FontWeight.w600),
                              ),
                              Slider(
                                value: value,
                                min: 0,
                                max: 50,
                                label: '${value.toInt()}',
                                activeColor:
                                    const ui.Color.fromARGB(255, 119, 116, 116),
                                inactiveColor:
                                    const ui.Color.fromARGB(255, 203, 198, 198),
                                onChanged: (val) {
                                  eraserSize.value = val;
                                },
                              ),
                            ]);
                          },
                        ),
                      ),
                    ];
                  },
                ),
              ),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () async {
                  Uint8List? pngBytes = await getBytes();
                  if (pngBytes != null) {
                    () {
                      saveFile(pngBytes, context);
                    }();
                  }
                },
                child: Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Icon(Icons.send_outlined, size: 30),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> saveFile(Uint8List bytes, BuildContext context) async {
    final cacheDirectory = await getTemporaryDirectory();

    final uniqueFileName1 = DateTime.now().toString();
    final filePath1 = '${cacheDirectory.path}/$uniqueFileName1.png';

    final file1 = File(filePath1);
    await file1.writeAsBytes(bytes);

    String filePath2 = '';

    if (backgroundImage.value != null) {
      final uniqueFileName2 = DateTime.now().toString();
      filePath2 = '${cacheDirectory.path}/$uniqueFileName2.png';

      final file2 = File(filePath2);
      await file2.writeAsBytes((await backgroundImage.value
                  ?.toByteData(format: ui.ImageByteFormat.png))
              ?.buffer
              .asUint8List() ??
          []);
    }
    if (!fromChat) {
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chat(
                      user: user,
                      draw: {
          'sketch': filePath1,
          'backgroundImage': filePath2,
        },
                    )));
      }();
    } else {
      () {
        Navigator.pop(context, {
          'sketch': filePath1,
          'backgroundImage': filePath2,
        });
      }();
    }
  }

  Future<ui.Image> get _getImage async {
    final completer = Completer<ui.Image>();
    if (!kIsWeb && !Platform.isAndroid && !Platform.isIOS) {
      final file = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      if (file != null) {
        final filePath = file.files.single.path;
        final bytes = filePath == null
            ? file.files.first.bytes
            : File(filePath).readAsBytesSync();
        if (bytes != null) {
          completer.complete(decodeImageFromList(bytes));
        } else {
          completer.completeError('No image selected');
        }
      }
    } else {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        completer.complete(
          decodeImageFromList(bytes),
        );
      } else {
        completer.completeError('No image selected');
      }
    }

    return completer.future;
  }

  Future<Uint8List?> getBytes() async {
    RenderRepaintBoundary boundary = canvasGlobalKey.currentContext
        ?.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List? pngBytes = byteData?.buffer.asUint8List();
    return pngBytes;
  }
}

///A data structure for undoing and redoing sketches.
class _UndoRedoStack {
  _UndoRedoStack({
    required this.sketchesNotifier,
    required this.currentSketchNotifier,
  }) {
    _sketchCount = sketchesNotifier.value.length;
    sketchesNotifier.addListener(_sketchesCountListener);
  }

  final ValueNotifier<List<Sketch>> sketchesNotifier;
  final ValueNotifier<Sketch?> currentSketchNotifier;

  ///Collection of sketches that can be redone.
  late final List<Sketch> _redoStack = [];

  ///Whether redo operation is possible.
  ValueNotifier<bool> get canRedo => _canRedo;
  late final ValueNotifier<bool> _canRedo = ValueNotifier(false);

  late int _sketchCount;

  void _sketchesCountListener() {
    if (sketchesNotifier.value.length > _sketchCount) {
      //if a new sketch is drawn,
      //history is invalidated so clear redo stack
      _redoStack.clear();
      _canRedo.value = false;
      _sketchCount = sketchesNotifier.value.length;
    }
  }

  void clear() {
    _sketchCount = 0;
    sketchesNotifier.value = [];
    _canRedo.value = false;
    currentSketchNotifier.value = null;
  }

  void undo() {
    final sketches = List<Sketch>.from(sketchesNotifier.value);
    if (sketches.isNotEmpty) {
      _sketchCount--;
      _redoStack.add(sketches.removeLast());
      sketchesNotifier.value = sketches;
      _canRedo.value = true;
      currentSketchNotifier.value = null;
    }
  }

  void redo() {
    if (_redoStack.isEmpty) return;
    final sketch = _redoStack.removeLast();
    _canRedo.value = _redoStack.isNotEmpty;
    _sketchCount++;
    sketchesNotifier.value = [...sketchesNotifier.value, sketch];
  }

  void dispose() {
    sketchesNotifier.removeListener(_sketchesCountListener);
  }
}
