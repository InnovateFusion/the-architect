import 'package:architect/features/architect/domains/entities/chat.dart'
    as chat;
import 'package:architect/features/architect/presentations/bloc/chat/chat_bloc.dart';
import 'package:architect/features/architect/presentations/page/chat.dart';
import 'package:architect/features/architect/presentations/page/collabration/start.dart';
import 'package:architect/features/architect/presentations/page/edit_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
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
  late ChatBloc chatBloc;
  late chat.Chat xChat;

  void searchTeam(BuildContext context, String search) {
    if (search.isNotEmpty) {}
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  void initState() {
    super.initState();
    chatBloc = sl<ChatBloc>();
    chatBloc.add(
      ChatViewEvent(
        id: widget.team.id,
      ),
    );
    chatBloc.stream.listen((event) {
      if (event is ChatViewLoaded) {
        setState(() {
          xChat = event.chat;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 238, 244),
        body: BlocProvider(
          create: (context) => chatBloc,
          child: Padding(
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
                        Text(
                          capitalize(widget.team.title).substring(0, 13),
                          softWrap: true,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
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
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return CoolCard(index: index);
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
                              size: 25,
                            ),
                            color: const Color.fromARGB(255, 0, 0, 0),
                            onPressed: () {
                              String image =
                                  "http://res.cloudinary.com/dtghsmx0s/image/upload/v1698736170/dvjkvrp0kmaalawyjty0.jpg";

                              if (widget.user.id ==
                                  "35a70fdf-7d7d-4f2f-a97c-5e1eeb5bc33a") {
                                image =
                                    "http://res.cloudinary.com/dtghsmx0s/image/upload/v1698643318/f9xg30zmx2v9n1k1tvvw.jpg";
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CollabDrawing(
                                      user: widget.user, image: image),
                                ),
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
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      return ActivityCard(activity: activities[index]);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CoolCard extends StatelessWidget {
  final int index;

  const CoolCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
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
                  images[index],
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
                  users[index],
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

List images = [
  'https://images.pexels.com/photos/3760529/pexels-photo-3760529.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  "https://images.pexels.com/photos/1915906/pexels-photo-1915906.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
  "https://images.pexels.com/photos/6707628/pexels-photo-6707628.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
];

List users = [
  'http://res.cloudinary.com/dtghsmx0s/image/upload/v1698643318/f9xg30zmx2v9n1k1tvvw.jpg',
  'http://res.cloudinary.com/dtghsmx0s/image/upload/v1698642634/u640aw5vgzzuzowsbgp7.jpg',
  'http://res.cloudinary.com/dtghsmx0s/image/upload/v1698662416/tj6ujvmkzsx3s75mnyvr.jpg'
];

class ActivityList extends StatelessWidget {
  final List<Activity> activities;

  ActivityList(this.activities);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: activities.length,
      itemBuilder: (context, index) {
        return ActivityCard(activity: activities[index]);
      },
    );
  }
}

class ActivityCard extends StatelessWidget {
  final Activity activity;

  ActivityCard({required this.activity});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activity.title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5.0),
            Text(activity.description),
          ],
        ),
      ),
    );
  }
}

class Activity {
  final String title;
  final String description;

  Activity(this.title, this.description);
}

final List<Activity> activities = [
  Activity("House Interior - 1", "Design a house interior"),
  Activity("X-1 Exterior", "Design a house exterior"),
  Activity("SkyScrapper One", "Work on a skyscraper"),
];
