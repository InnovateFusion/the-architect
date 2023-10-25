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

void _showImageInFull(BuildContext context, String image) {
  showDialog(
    context: context,
    useSafeArea: true,
    builder: (_) => Dialog(
      child: Image.network(
        image,
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
            content: message,
            isSentByMe: message.isSentByMe,
          );
        },
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final Message content;
  final bool isSentByMe;
  final VoidCallback onDeleted;

  const ChatMessage({
    super.key,
    required this.onDeleted,
    required this.content,
    required this.isSentByMe,
  });

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  String capitalizeAll(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input.split(' ').map((e) => capitalize(e)).join(' ');
  }

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
      Colors.black.withOpacity(0.5),
      BlendMode.darken,
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          if (isSentByMe && !content.isPicked)
            if (content.imageUser.isEmpty)
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: borderRadius,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  content.prompt,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          if (content.imageUser.isNotEmpty)
            Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: borderRadius,
                ),
                child: Column(
                  children: [
                    Image.network(
                      content.imageUser,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        capitalize(content.prompt),
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                )),
          if (isSentByMe && content.isPicked)
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
                            File(content.imageUser),
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
          if (!isSentByMe && content.imageAI.isNotEmpty)
            GestureDetector(
              onDoubleTap: () => _showImageInFull(context, content.imageAI),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network(
                    content.imageAI,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          if (!isSentByMe && content.chat.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: borderRadius,
              ),
              padding: const EdgeInsets.all(10.0),
              child: Text(
                content.chat,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          if (!isSentByMe &&
              content.analysis.containsKey('title') &&
              content.analysis['title'].isNotEmpty &&
              content.analysis.containsKey('detail') &&
              content.analysis['detail'].isNotEmpty)
            Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: borderRadius,
                ),
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        capitalizeAll(content.analysis['title']),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      content.analysis['detail'],
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(
                      height: 5,
                    )
                  ],
                )),
        ],
      ),
    );
  }
}
