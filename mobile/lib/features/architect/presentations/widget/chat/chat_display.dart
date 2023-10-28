import 'package:architect/features/architect/presentations/widget/chat/chat_message.dart';
import 'package:flutter/material.dart';

import '../../../domains/entities/user.dart';
import '../../page/chat.dart';

class ChatDisplay extends StatefulWidget {
  const ChatDisplay({
    required this.user,
    Key? key,
    required this.messages,
  }) : super(key: key);

  final User user;
  final List<Message> messages;

  @override
  State<ChatDisplay> createState() => _ChatDisplayState();
}

class _ChatDisplayState extends State<ChatDisplay> {
  void onDeleted() {
    setState(() {
      widget.messages.removeAt(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return displayMessage();
  }

  Flexible displayMessage() {
    return widget.messages.isEmpty
        ? Flexible(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: widget.messages.isEmpty ? 1.0 : 0.0,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.0, 0.5),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: const AlwaysStoppedAnimation(1),
                  curve: Curves.fastOutSlowIn,
                )),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Start a New Chat",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Flexible(
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
                  user: widget.user,
                  messages: widget.messages,
                  onDeleted: onDeleted,
                  content: message,
                  isSentByMe: message.isSentByMe,
                );
              },
            ),
          );
  }
}
