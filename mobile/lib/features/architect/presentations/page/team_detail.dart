import 'package:architect/features/architect/domains/entities/chat.dart'
    as chat;
import 'package:architect/features/architect/presentations/bloc/chat/chat_bloc.dart';
import 'package:architect/features/architect/presentations/bloc/sketch/sketch_bloc.dart';
import 'package:architect/features/architect/presentations/bloc/user/user_bloc.dart';
import 'package:architect/features/architect/presentations/page/chat.dart';
import 'package:architect/features/architect/presentations/page/collabration/start.dart';
import 'package:architect/features/architect/presentations/page/edit_team.dart';
import 'package:architect/features/architect/presentations/page/skeleton/team_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../injection_container.dart';
import '../../domains/entities/sketch.dart';
import '../../domains/entities/team.dart';
import '../../domains/entities/user.dart' as x_user;

class TeamDetail extends StatefulWidget {
  const TeamDetail({Key? key, required this.user, required this.team})
      : super(key: key);

  final x_user.User user;
  final Team team;

  @override
  State<TeamDetail> createState() => _TeamDetailState();
}

class _TeamDetailState extends State<TeamDetail> {
  late ChatBloc chatBloc = chatBloc = sl<ChatBloc>();
  late SketchBloc sketchBloc = sl<SketchBloc>();
  late UserBloc userBloc = sl<UserBloc>();
  late chat.Chat xChat;
  String image = '';
  final List<ImageCardInfo> messageImages = [];

  final TextEditingController textController = TextEditingController();

  void searchTeam(BuildContext context, String search) {
    if (search.isNotEmpty) {}
  }

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
  void initState() {
    super.initState();
    userBloc.add(ViewUserEvent(id: widget.user.id));
    chatBloc.add(
      ChatViewEvent(
        id: widget.team.id,
      ),
    );
    userBloc.stream.listen((state) {
      if (state is UserLoaded) {
        setState(() {
          image = state.user.image;
        });
      }
    });
    chatBloc.stream.listen((event) {
      if (event is ChatViewLoaded) {
        setState(() {
          xChat = event.chat;
        });

        for (var element in event.chat.messages) {
          if (element.sender == 'ai') {
            String image = element.content["image"].toString();
            String value = element.content["imageAI"].toString();
            if (value.isNotEmpty) {
              messageImages.add(
                ImageCardInfo(imageAi: value, nameUser: image),
              );
            }
          }
        }
      }
    });

    sketchBloc.add(
      SketchEventViews(
        teamId: widget.team.id,
      ),
    );
  }

  @override
  void dispose() {
    textController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 238, 244),
        body: BlocProvider(
          create: (context) => sketchBloc,
          child: BlocProvider(
            create: (context) => chatBloc,
            child: BlocConsumer<SketchBloc, SketchState>(
              listener: (context, state) {
                if (state.statusSketch == SketchStatus.success ||
                    state.statusAll == SketchstatusAll.success) {
                  setState(() {});
                }
              },
              builder: (context, state) {
                if (state.statusSketch == SketchStatus.loading ||
                    state.statusAll == SketchstatusAll.loading) {
                  return const TeamDetailShimmer();
                } else if (state.statusSketch == SketchStatus.failure ||
                    state.statusAll == SketchstatusAll.failure) {
                  return const Center(
                    child: Text("Unable to load sketches"),
                  );
                } else {
                  return dispayContent(context);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding dispayContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff22c55e),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 40,
                    width: 40,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                      child: CircleAvatar(
                        backgroundImage: Image.asset(
                          'assets/images/user.png',
                        ).image,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                widget.team.image,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeamPageEdit(
                              user: widget.user,
                              team: widget.team,
                            ),
                          ),
                        );
                      }),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        capitalizeAll(widget.team.title),
                        softWrap: true,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Created by ${widget.team.firstName}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      if (state is ChatViewLoaded) {
                        return Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: const Color(0xff22c55e),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: IconButton(
                              icon: const Icon(
                                Icons.chat,
                                size: 25,
                              ),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Chat(
                                      user: widget.user,
                                      team: widget.team,
                                      messages: state.chat.messages,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Center();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount:
                  messageImages.isEmpty ? images.length : messageImages.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return CoolCard(index: index, messageImages: messageImages);
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      "Sketches",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(
                      "Model Train",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.add,
                        size: 20,
                      ),
                      color: const Color.fromARGB(255, 0, 0, 0),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (cntx) {
                            return AlertDialog(
                              title: Column(
                                children: [
                                  const Row(
                                    children: [
                                      Text(
                                        "New",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Sketch",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  TextField(
                                    controller: textController,
                                    onChanged: (value) => setState(() {}),
                                    decoration: const InputDecoration(
                                      hintText: "Title",
                                      hintStyle: TextStyle(
                                        color: Color.fromRGBO(151, 146, 146, 1),
                                        fontSize: 16,
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(top: 12, bottom: 12),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ],
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(cntx).pop();
                                  },
                                  child: const Text("Cancel",
                                      style: TextStyle(color: Colors.black)),
                                ),
                                TextButton(
                                  onPressed: () {
                                    sketchBloc.add(SketchEventCreate(
                                        title: textController.text,
                                        teamId: widget.team.id));
                                  },
                                  child: const Text("Add",
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: sketchBloc.state.sketches.length,
              itemBuilder: (context, index) {
                return ActivityCard(
                  id: sketchBloc.state.sketches[index].id,
                  text: sketchBloc.state.sketches[index].title,
                  image: image,
                  user: widget.user,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CoolCard extends StatelessWidget {
  final int index;
  final List<ImageCardInfo> messageImages;

  const CoolCard({Key? key, required this.index, required this.messageImages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: messageImages.isEmpty
          ? Stack(children: [
              Card(
                elevation: 0,
                margin: const EdgeInsets.only(right: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ])
          : Stack(
              children: [
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.only(right: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 3),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        messageImages[index].imageAi,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 15,
                  child: CircleAvatar(
                    radius: 17.5,
                    backgroundColor: Colors.blue,
                    child: ClipOval(
                      child: Image.network(
                        messageImages[index].nameUser,
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class ActivityList extends StatelessWidget {
  final List<Sketch> sketches;
  final String image;
  final x_user.User user;
  const ActivityList(
      {required this.sketches,
      Key? key,
      required this.image,
      required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sketches.length,
      itemBuilder: (context, index) {
        return ActivityCard(
          id: sketches[index].id,
          text: sketches[index].title,
          image: image,
          user: user,
        );
      },
    );
  }
}

class ActivityCard extends StatefulWidget {
  final String text;
  final String id;
  final String image;
  final x_user.User user;

  const ActivityCard(
      {required this.text,
      Key? key,
      required this.id,
      required this.image,
      required this.user})
      : super(key: key);

  @override
  State<ActivityCard> createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  late SketchBloc sketchBloc = sl<SketchBloc>();
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(const Uuid().v4()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          showDialog(
            context: context,
            builder: (cntx) {
              return AlertDialog(
                title: const Text(
                  "Are you sure you want to delete this sketch?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(cntx).pop();
                      setState(() {});
                    },
                    child: const Text("Cancel",
                        style: TextStyle(color: Colors.black)),
                  ),
                  TextButton(
                    onPressed: () {
                      sketchBloc.add(SketchEventDelete(sketchId: widget.id));
                      Navigator.of(cntx).pop();
                    },
                    child: const Text("Delete",
                        style: TextStyle(color: Colors.red)),
                  ),
                ],
              );
            },
          );
        }
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CollabDrawing(
                  user: widget.user, image: widget.image, boardId: widget.id),
            ),
          );
        },
        child: Card(
          elevation: 2,
          color: const Color.fromARGB(255, 236, 238, 244),
          margin: const EdgeInsets.only(bottom: 15),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              capitalize(widget.text),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String capitalize(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

class ImageCardInfo {
  final String imageAi;
  final String nameUser;

  ImageCardInfo({
    required this.imageAi,
    required this.nameUser,
  });
}

List images = [
  'https://images.pexels.com/photos/3760529/pexels-photo-3760529.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  "https://images.pexels.com/photos/1915906/pexels-photo-1915906.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/6707628/pexels-photo-6707628.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
];
