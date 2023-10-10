import 'package:architect/features/architect/presentations/widget/chat/chat_display.dart';
import 'package:architect/features/architect/presentations/widget/chat/chat_side_bar.dart';
import 'package:flutter/material.dart';

import '../widget/chat/chat_input.dart';
import '../widget/profile_image.dart';

class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final messages = [
    Message(text: "Thank you", isSentByMe: true),
    Message(
        text:
            "https://images.pexels.com/photos/2792601/pexels-photo-2792601.jpeg",
        isSentByMe: false),
    Message(text: "Hi there! Give cool building image", isSentByMe: true),
  ];
  void handleSubmitted(String text) {
    setState(() {
      messages.insert(0, Message(text: text, isSentByMe: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding:
              const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: const Color(0xFFB5B2B3),
                            borderRadius: BorderRadius.circular(5)),
                        height: 40,
                        width: 40,
                        child: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Chat",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  const ProfileImage(
                      imageUrl: 'assets/images/me.jpg', size: 50.0),
                ],
              ),
              const SizedBox(height: 15),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const ChatSideBar(),
                    ChatDisplay(messages: messages),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              ChatInput(
                onSubmitted: handleSubmitted,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
