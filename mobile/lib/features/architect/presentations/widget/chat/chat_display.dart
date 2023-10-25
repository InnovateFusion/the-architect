import 'dart:io';

import 'package:flutter/material.dart';

import '../../page/chat.dart';

class ChatDisplay extends StatefulWidget {
  const ChatDisplay({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<Message> messages;

  @override
  State<ChatDisplay> createState() => _ChatDisplayState();
}

void _showImageInFull(BuildContext context, String text) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (_) => Dialog(
      child: Image.network(
        text,
        fit: BoxFit.contain,
      ),
    ),
  );
}

class _ChatDisplayState extends State<ChatDisplay> {
  void onDeleted() {
    setState(() {
      widget.messages.removeAt(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        physics: const ClampingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        reverse: true,
        padding: const EdgeInsets.all(8.0),
        itemCount: widget.messages.length,
        itemBuilder: (_, int index) {
          final message = widget.messages[index];
          return ChatMessage(
            onDeleted: onDeleted,
            isPicked: message.isPicked,
            text: message.text,
            isSentByMe: message.isSentByMe,
          );
        },
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final bool isPicked;
  final VoidCallback onDeleted;

  const ChatMessage({
    super.key,
    required this.onDeleted,
    required this.isPicked,
    required this.text,
    required this.isSentByMe,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.only(
      topLeft:
          isSentByMe ? const Radius.circular(20.0) : const Radius.circular(0.0),
      topRight:
          isSentByMe ? const Radius.circular(0.0) : const Radius.circular(20.0),
      bottomLeft: const Radius.circular(20.0),
      bottomRight: const Radius.circular(20.0),
    );

    final alignment =
        isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;

    ColorFilter colorFilter = ColorFilter.mode(
      Colors.black.withOpacity(0.5), // Adjust the opacity to control darkness
      BlendMode.darken, // You can use other BlendModes as well
    );

    print("The text is $text");
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          if (isSentByMe && !isPicked)
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: borderRadius,
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          if (isSentByMe && isPicked)
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: 400,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: ColorFiltered(
                          colorFilter: colorFilter,
                          child: Image.file(
                            File(text),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          iconSize: 50,
                          color: const Color.fromARGB(255, 255, 255, 255),
                          icon: const Icon(Icons.cancel),
                          onPressed: onDeleted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (!isSentByMe)
            GestureDetector(
              onDoubleTap: () => _showImageInFull(context, text),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    text,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
