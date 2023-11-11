import 'dart:io';

import 'package:architect/features/architect/presentations/bloc/team/team_bloc.dart';
import 'package:architect/features/architect/presentations/page/create_team.dart';
import 'package:architect/features/architect/presentations/page/skeleton/team.dart';
import 'package:architect/features/architect/presentations/page/team_detail.dart';
import 'package:architect/features/architect/presentations/widget/error.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../injection_container.dart';
import '../../domains/entities/team.dart';
import '../../domains/entities/user.dart';
import 'setting.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  TeamBloc teamBloc = sl<TeamBloc>();
  List<Team> teams = [];
  List<Team> filterTeamSearch = [];
  final TextEditingController searchController =
      TextEditingController(text: '');

  @override
  void initState() {
    super.initState();

    teamBloc.add(const TeamViewsEvent());
    teamBloc.stream.listen((event) {
      if (event.statusAll == TeamstatusAll.success) {
        setState(() {
          teams = event.teams;
        });
      }
    });
  }

  void searchTeam(BuildContext context, String search) {
    if (search.isNotEmpty) {
      filterTeamSearch.clear();
      filteredAllTeam(search);
    } else {
      setState(() {
        filterTeamSearch.clear();
      });
    }
  }

  void filteredAllTeam(String value) {
    setState(() {
      if (value.isNotEmpty) {
        for (var team in teams) {
          if (team.title.toLowerCase().contains(value.toLowerCase())) {
            filterTeamSearch.add(team);
          }
        }
      }
    });
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 238, 244),
        body: BlocProvider(
          create: (context) => teamBloc,
          child: BlocBuilder<TeamBloc, TeamState>(
            builder: (context, state) {
              if (state.statusAll == TeamstatusAll.initial ||
                  state.statusAll == TeamstatusAll.loading) {
                return const TeamShimmer();
              } else if (state.statusAll == TeamstatusAll.success) {
                return displayTeams(context);
              } else {
                return RefreshIndicator(
                  onRefresh: () {
                    teamBloc.add(const TeamViewsEvent());
                    return Future<void>.value();
                  },
                  color: Colors.black,
                  child: ListView(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4),
                    children: const [
                      Center(
                          child: ErrorDisplay(
                              message: 'Connect to internet. Refresh it.'))
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Padding displayTeams(BuildContext context) {
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
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Team",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Chat",
                    style: TextStyle(
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xff22c55e),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          size: 25,
                        ),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TeamPageCreate(user: widget.user)),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Setting(
                          user: widget.user,
                        ),
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: Image.asset(
                        'assets/images/user.png',
                      ).image,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: DecorationImage(
                              image: Image.file(
                                File(widget.user.image),
                                fit: BoxFit.cover,
                              ).image,
                            ).image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: searchController,
              onChanged: (value) => setState(() {
                searchTeam(context, value);
              }),
              decoration: InputDecoration(
                hintText: "Search Team",
                hintStyle: const TextStyle(
                  color: Color.fromRGBO(151, 146, 146, 1),
                  fontSize: 16,
                ),
                contentPadding: const EdgeInsets.only(top: 12, bottom: 12),
                border: InputBorder.none,
                suffixIcon: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xff22c55e),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.search,
                      size: 25,
                    ),
                    color: Colors.white,
                    onPressed: () {
                      searchTeam(context, searchController.text);
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 150,
            child: ListView.builder(
              itemCount: teams.length > 3 ? 3 : teams.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return CoolCard(team: teams[index]);
              },
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              itemCount: searchController.text.isEmpty
                  ? teams.length
                  : filterTeamSearch.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TeamDetail(
                          team: searchController.text.isEmpty
                              ? teams[index]
                              : filterTeamSearch[index],
                          user: widget.user,
                        ),
                      ),
                    );
                  },
                  child: Dismissible(
                    key: Key(const Uuid().v4()),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart) {
                        showDialog(
                          context: context,
                          builder: (cntx) {
                            return AlertDialog(
                              title: const Text(
                                "Are you sure you want to delete this team?",
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
                                    teamBloc.add(
                                      TeamDeleteEvent(
                                        id: searchController.text.isEmpty
                                            ? teams[index].id
                                            : filterTeamSearch[index].id,
                                      ),
                                    );
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
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: NetworkImage(searchController.text.isEmpty
                                ? teams[index].image.isEmpty
                                    ? imageXUrl
                                    : teams[index].image
                                : filterTeamSearch[index].image.isEmpty
                                    ? imageXUrl
                                    : filterTeamSearch[index].image),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6),
                              BlendMode.darken,
                            ),
                          ),
                        ),
                        height: 80,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            searchController.text.isEmpty
                                                ? teams[index].image.isEmpty
                                                    ? imageXUrl
                                                    : teams[index].image
                                                : filterTeamSearch[index]
                                                        .image
                                                        .isEmpty
                                                    ? imageXUrl
                                                    : filterTeamSearch[index]
                                                        .image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      capitalize(searchController.text.isEmpty
                                          ? teams[index].title
                                          : filterTeamSearch[index].title),
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 10,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      'Created by ${searchController.text.isEmpty ? teams[index].firstName : filterTeamSearch[index].firstName}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 177, 164, 164),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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
  final Team team;

  const CoolCard({Key? key, required this.team}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      height: 130,
      child: Card(
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
              team.image.isEmpty ? imageXUrl : team.image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

String imageXUrl =
    'https://images.pexels.com/photos/3760529/pexels-photo-3760529.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1';
