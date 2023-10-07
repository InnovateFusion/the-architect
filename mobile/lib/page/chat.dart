import 'package:architect/widget/chat/chat_input.dart';
import 'package:architect/widget/chat/chat_side_bar.dart';
import 'package:flutter/material.dart';

import '../widget/profile_image.dart';

class Chat extends StatelessWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              const ChatSideBar(),
              const ChatInput(),
            ],
          ),
        ),
      ),
    );
  }
}

