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

  const ChatMessage({
    super.key,
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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          if (isSentByMe)
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
