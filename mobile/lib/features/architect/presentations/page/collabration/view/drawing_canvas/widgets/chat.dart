import 'dart:async';
import 'dart:convert';

import 'package:architect/features/architect/presentations/page/collabration/start.dart';
import 'package:architect/features/architect/presentations/page/collabration/view/drawing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatDisplay extends HookWidget {
  final ValueNotifier<List<Chat>> allChat;
  final User user;
  final String id;

  ChatDisplay({
    Key? key,
    required this.id,
    required this.allChat,
    required this.user,
  }) : super(key: key);

  final TextEditingController textController = TextEditingController();
  final chatStreamController = StreamController<String>();
  final isExpanded = useState(false);

  final IO.Socket socket = IO.io(
    'https://sketch-dq5zwrwm5q-ww.a.run.app',
    IO.OptionBuilder().setTransports(['websocket']).build(),
  )..connect();

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      socket.emit(
          'chat',
          jsonEncode({
            'id': id,
            'chat': jsonEncode(Chat(message: message, user: user)),
          }));
    }
  }

  void changeExpanded() => isExpanded.value = !isExpanded.value;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      socket.onConnect((_) {
        socket.on('allChat-$id', (data) {
          chatStreamController.sink.add(data);
          allChat.value = (jsonDecode(data) as List)
              .map((json) => Chat.fromJson(json as Map<String, dynamic>))
              .toList();
        });
        return () {
          textController.dispose();
          chatStreamController.close();
          chatStreamController.sink.close();
          socket.disconnect();
        };
      });
    }, []);

    socket.onConnect((_) {
      print('connect');
    });

    socket.on('allChat-$id', (data) {
      chatStreamController.sink.add(data);
      allChat.value = (jsonDecode(data) as List)
          .map((json) => Chat.fromJson(json as Map<String, dynamic>))
          .toList();
    });

    return allChatDisplay();
  }

  Widget buildAllPaths() {
    return StreamBuilder(
      stream: chatStreamController.stream,
      builder: (context, snapshot) {
        List<Chat> chats = List.empty(growable: true);
        List chatMap = List.empty(growable: true);

        if (snapshot.hasData) {
          chatMap = jsonDecode(snapshot.data!);
          chats = chatMap
              .map((json) => Chat.fromJson(json as Map<String, dynamic>))
              .toList();
        }

        return SizedBox(
          height: 200,
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  NetworkImage(chats[index].user.image),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                chats[index].user.name,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                capitalize(
                                  chats[index].message.substring(
                                      0,
                                      chats[index].message.length > 20
                                          ? 20
                                          : chats[index].message.length),
                                ),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Container allChatDisplay() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      width: 250,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                    child: const Icon(
                      Icons.chat,
                      color: Color(0xff22c55e),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Text(
                    'Live Chat',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff22c55e),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: changeExpanded,
                child: Icon(
                  isExpanded.value ? Icons.expand_more : Icons.expand_less,
                  color: const Color(0xff22c55e),
                  size: 35,
                ),
              ),
            ],
          ),
          if (isExpanded.value) buildAllPaths(),
          if (isExpanded.value)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      focusColor: Colors.greenAccent,
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color.fromARGB(255, 142, 231, 175),
                  ),
                  onPressed: () {
                    sendMessage(textController.text);
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
