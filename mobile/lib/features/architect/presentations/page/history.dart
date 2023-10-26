import 'package:architect/features/architect/domains/entities/chat.dart';
import 'package:architect/features/architect/domains/entities/message.dart';
import 'package:architect/features/architect/presentations/page/chat.dart'
    as chat;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

import '../../../../injection_container.dart';
import '../bloc/chat/chat_bloc.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final List<Chat> history = [];
  final List<Chat> filteredHistory = [];
  final TextEditingController searchController = TextEditingController();
  late ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    chatBloc = sl<ChatBloc>();
    chatBloc.add(
      const ChatViewsEvent(
        userId: '35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a',
      ),
    );
    chatBloc.stream.listen((event) {
      if (event is ChatViewsLoaded) {
        setState(() {
          history.addAll(event.chats);
        });
      }
    });
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  void conformationOfDeletion(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Delete Task"),
        content: const Text("Are you sure you want to delete this chat?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text("No", style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              chatBloc.add(
                ChatDeleteEvent(
                  id: id,
                ),
              );
              setState(() {
                history.removeWhere((element) => element.id == id);
              });

              Navigator.of(ctx).pop(true);
            },
            child: const Text("Yes", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void onPressedNavigation(
      BuildContext context, String id, String userId, List<Message> messages) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => chat.Chat(
          chatId: id,
          userId: userId,
          messages: messages,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return historyLoaded(context);
  }

  Widget historyLoaded(BuildContext context) {
    return SafeArea(
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
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
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
                            controller: searchController,
                            onChanged: (value) {
                              setState(() {
                                filteredHistory.clear();
                                filteredHistory.addAll(
                                  history.where(
                                    (element) => element.title
                                        .toLowerCase()
                                        .contains(value.toLowerCase()),
                                  ),
                                );
                              });
                            },
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
            StreamBuilder(
              stream: chatBloc.stream,
              builder: (BuildContext context, AsyncSnapshot<Object> snapshot) {
                if (snapshot.hasData) {
                  final event = snapshot.data;
                  if (history.isNotEmpty) {
                    return historyMethod();
                  } else if (event is ChatViewsLoaded) {
                    history.clear();
                    history.addAll(event.chats);
                    return historyMethod();
                  } else if (event is ChatError) {
                    return Expanded(child: Center(child: Text(event.message)));
                  }
                }
                return Expanded(
                  child: Center(
                    child: SpinKitWave(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: index.isEven
                                ? const Color.fromARGB(255, 0, 0, 0)
                                : Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Expanded historyMethod() {
    return Expanded(
      child: ListView.builder(
        itemCount: searchController.text.isNotEmpty
            ? filteredHistory.length
            : history.length,
        itemBuilder: (context, index) {
          final view = searchController.text.isNotEmpty
              ? filteredHistory[index]
              : history[index];
          return ListTile(
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            hoverColor: Colors.grey,
            subtitle: GestureDetector(
              onTap: () => onPressedNavigation(
                context,
                view.id,
                view.userId,
                view.messages,
              ),
              child: Text(
                DateFormat('MMM d y')
                    .format(view.messages[view.messages.length - 1].date),
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            title: GestureDetector(
              onTap: () => onPressedNavigation(
                context,
                view.id,
                view.userId,
                view.messages,
              ),
              child: Text(view.title.length <= 30
                  ? capitalize(view.title)
                  : '${capitalize(view.title.substring(0, 30))}...'),
            ),
            trailing: GestureDetector(
              onTap: () {
                conformationOfDeletion(context, view.id);
              },
              child: const Icon(
                Icons.delete,
                size: 30,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          );
        },
      ),
    );
  }
}
