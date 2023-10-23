import 'package:architect/features/architect/domains/entities/message.dart'
    as message;
import 'package:architect/features/architect/presentations/bloc/chat/chat_bloc.dart';
import 'package:architect/features/architect/presentations/widget/chat/chat_display.dart';
import 'package:architect/features/architect/presentations/widget/chat/chat_side_bar.dart';
import 'package:architect/features/architect/presentations/widget/drawer.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/chat/chat_input.dart';
import '../widget/profile_image.dart';

class Message {
  final String text;
  final bool isSentByMe;

  Message({required this.text, required this.isSentByMe});
}

class Chat extends StatefulWidget {
  const Chat({Key? key, this.messages, this.chatId, this.userId})
      : super(key: key);

  final List<message.Message>? messages;
  final String? chatId;
  final String? userId;

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    if (widget.messages != null) {
      for (var message in widget.messages!) {
        messages.add(Message(
            text: message.content,
            isSentByMe: message.sender == 'user' ? true : false));
      }
      messages = messages.reversed.toList();
    } else {
      messages = [];
    }
  }

  void handleSubmitted(BuildContext context, String text) {
    if (text.isEmpty) return;

    var payload = {
      "model": "stable-diffusion-v1-5",
      "prompt": text,
      "negative_prompt": "Disfigured, cartoon, blurry",
      "width": 512,
      "height": 512,
      "steps": 25,
      "guidance": 7.5,
      "seed": 0,
      "scheduler": "dpmsolver++",
      "output_format": "jpeg"
    };

    if (widget.chatId != null) {
      BlocProvider.of<ChatBloc>(context).add(MakeChatEvent(
        userId: widget.userId!,
        payload: payload,
        chatId: widget.chatId!,
        model: 'text_to_image',
      ));
    } else {
      BlocProvider.of<ChatBloc>(context).add(ChatCreateEvent(
        userId: "35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a",
        payload: payload,
        model: 'text_to_image',
      ));
    }
    setState(() {
      messages.insert(0, Message(text: text, isSentByMe: true));
    });
  }

  void reveiveMessage(String text) {
    setState(() {
      messages.insert(0, Message(text: text, isSentByMe: false));
    });
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ChatBloc>(
              create: (context) => sl<ChatBloc>()
                ..add(const ChatViewEvent(
                    id: '35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a'))),
          BlocProvider(
            create: (context) => sl<ChatBloc>()
              ..add(
                const ChatViewsEvent(
                  userId: '35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a',
                ),
              ),
          ),
        ],
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          drawer: const Drawer(
            child: CustomDrawer(),
          ),
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
                              color: const Color.fromARGB(255, 0, 0, 0),
                              borderRadius: BorderRadius.circular(5)),
                          height: 40,
                          width: 40,
                          child: GestureDetector(
                            onTap: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                            child: const Icon(
                              Icons.menu,
                              color: Colors.white,
                              size: 30,
                            ),
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
                      BlocListener<ChatBloc, ChatState>(
                        listener: (context, state) {
                          if (state is MakeChatLoaded) {
                            reveiveMessage(state.message.content);
                          }
                        },
                        child: ChatDisplay(messages: messages),
                      ),
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
      ),
    );
  }
}
