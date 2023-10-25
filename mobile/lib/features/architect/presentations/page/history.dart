import 'package:architect/features/architect/presentations/page/chat.dart'
    as chat;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/chat/chat_bloc.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  void onPressed(String search) {
    print('search');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatBloc>()
        ..add(
          const ChatViewsEvent(
            userId: '35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a',
          ),
        ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(children: [
                  Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: const Color(0xFFF4F0F3),
                        border: Border.all(
                          color: const Color(0xFFF4F0F3), // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Color.fromARGB(255, 0, 0, 0),
                                size: 25, // Example icon color
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              onSubmitted: (value) => onPressed('search'),
                              decoration: const InputDecoration(
                                hintText: 'Search',
                                hintStyle: TextStyle(
                                  color: Colors.grey, // Example hint text color
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (state is ChatLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is ChatViewsLoaded) {
                      return ListView.builder(
                        itemCount: state.chats.length,
                        itemBuilder: (context, index) {
                          final view = state.chats[index];
                          return ListTile(
                            titleTextStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            hoverColor: Colors.grey,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => chat.Chat(
                                            chatId: view.id,
                                            userId: view.userId,
                                            messages: view.messages,
                                          )));
                            },
                            title: Text(view.title.length <= 50
                                ? view.title
                                : view.title.substring(0, 50)),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Error'),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
