import 'dart:convert';
import 'dart:io';

import 'package:architect/features/architect/domains/entities/team.dart';
import 'package:architect/features/architect/presentations/bloc/team/team_bloc.dart';
import 'package:architect/features/architect/presentations/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../injection_container.dart';
import '../../domains/entities/user.dart';
import '../bloc/user/user_bloc.dart';

class TeamPageEdit extends StatefulWidget {
  const TeamPageEdit({Key? key, required this.user, required this.team})
      : super(key: key);

  final User user;
  final Team team;

  @override
  State<TeamPageEdit> createState() => _TeamPageCreateState();
}

class _TeamPageCreateState extends State<TeamPageEdit> {
  late UserBloc userBloc = sl<UserBloc>();
  late TeamBloc teamBloc = sl<TeamBloc>();
  void searchTeam(BuildContext context, String search) {
    if (search.isNotEmpty) {
      filteredUsers.clear();
      filteredAllUsers(search);
    } else {
      setState(() {
        filteredUsers.clear();
      });
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  late List<User> users = [];
  final List<User> filteredUsers = [];
  final Set<String> selectedUsers = {};
  String base64ImageForImageToImage = '';
  String imagePath = '';

  void _selectedUsers(String value) {
    if (selectedUsers.contains(value)) {
      selectedUsers.remove(value);
    } else {
      selectedUsers.add(value);
    }
  }

  void filteredAllUsers(String value) {
    setState(() {
      if (value.isNotEmpty) {
        for (var user in users) {
          if (user.firstName.toLowerCase().contains(value.toLowerCase())) {
            filteredUsers.add(user);
          }
        }
      }
    });
  }

  bool isSelected(String value) => selectedUsers.contains(value);

  void onSubmit() {
    print(_titleController.text);
    print(_descriptionController.text);

    teamBloc.add(
      TeamUpdateEvent(
        id: widget.team.id,
        title: _titleController.text,
        description: _descriptionController.text,
        image: base64ImageForImageToImage,
        members: selectedUsers.toList(),
      ),
    );

    teamBloc.add(TeamMemberAddsEvent(
        teamId: widget.team.id, userId: selectedUsers.toList()));

    teamBloc.stream.listen((event) {
      if (event.statusTeam == TeamStatus.success) {}
    });
  }

  Future<String> imageToBase64(String imagePath) async {
    final File imageFile = File(imagePath);

    if (await imageFile.exists()) {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      return base64Image;
    } else {
      return '';
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    }

    setState(() {
      imagePath = pickedImage.path;
    });
    imagePath = pickedImage.path;
    base64ImageForImageToImage = await imageToBase64(pickedImage.path);
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = capitalize(widget.team.title);
    _descriptionController.text = capitalize(widget.team.description);

    if (widget.team.creatorId == widget.user.id) {
      userBloc.add(const ViewsUserEvent());
      userBloc.stream.listen((event) {
        if (event is UsersViewsLoaded) {
          setState(() {
            users = event.users;
          });
        }
      });
      teamBloc.add(TeamMembersEvent(teamId: widget.team.id));
      teamBloc.stream.listen((event) {
        if (event.statusMember == TeamMember.success) {
          setState(() {
            selectedUsers.addAll(event.users.map((e) => e.id));
          });
        }
      });
    } else {
      teamBloc.add(TeamMembersEvent(teamId: widget.team.id));
      teamBloc.stream.listen((event) {
        if (event.statusMember == TeamMember.success) {
          setState(() {
            users = event.users;
          });
        }
      });
    }
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => userBloc,
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 236, 238, 244),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
              ),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state is UserInitial) {
                    return displayUsers(context);
                  } else if (state is UserLoading) {
                    return const Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 350),
                            child: LoadingIndicator()));
                  } else if (state is UsersViewsLoaded) {
                    for (var i = 0; i < state.users.length; i++) {
                      if (state.users[i].id == widget.user.id) {
                        selectedUsers.add(state.users[i].id);
                      }
                    }
                    return displayUsers(context);
                  } else {
                    return const Center(
                        child: Padding(
                            padding: EdgeInsets.only(top: 350),
                            child: Text("Error loading data!")));
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column displayUsers(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xff22c55e),
                borderRadius: BorderRadius.circular(5),
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
          ],
        ),
        Stack(
          children: [
            Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imagePath.isNotEmpty
                      ? FileImage(File(
                          imagePath.isEmpty ? widget.user.image : imagePath))
                      : Image.network(widget.team.image).image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            if (widget.team.creatorId == widget.user.id)
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    _pickImage();
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 181, 178, 179),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 5),
        if (widget.team.creatorId == widget.user.id)
          Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  hintText: 'Title',
                ),
                onChanged: (value) => setState(
                  () {
                    _titleController.text = value;
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  hintText: 'Description',
                ),
                onChanged: (value) => setState(
                  () {
                    _descriptionController.text = value;
                  },
                ),
              ),
            ],
          ),
        if (widget.team.creatorId != widget.user.id)
          Column(
            children: [
              const SizedBox(height: 10),
              Text(
                capitalize(widget.team.title),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    child: CircleAvatar(
                      radius: 15,
                      backgroundImage:
                          Image.network(widget.team.creatorImage).image,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    capitalize(
                        "Created by ${widget.team.firstName} ${widget.team.lastName}"),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                capitalize(widget.team.description),
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        const SizedBox(height: 30),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Team",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                  hintText: "Search users",
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
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            itemCount: searchController.text.isEmpty
                ? users.length
                : filteredUsers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    searchController.text.isEmpty
                        ? _selectedUsers(users[index].id)
                        : _selectedUsers(filteredUsers[index].id);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: searchController.text.isEmpty
                                    ? Image.network(users[index].image).image
                                    : Image.network(filteredUsers[index].image)
                                        .image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                searchController.text.isEmpty
                                    ? capitalize(
                                        "${users[index].firstName} ${users[index].lastName}")
                                    : capitalize(
                                        "${filteredUsers[index].firstName} ${filteredUsers[index].lastName}"),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (widget.team.creatorId == widget.user.id)
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: Icon(
                            searchController.text.isEmpty
                                ? isSelected(users[index].id)
                                    ? Icons.check
                                    : Icons.minimize
                                : isSelected(filteredUsers[index].id)
                                    ? Icons.check
                                    : Icons.minimize,
                            color: const Color.fromARGB(136, 19, 16, 16),
                            size: 30,
                          ),
                        )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (widget.team.creatorId == widget.user.id) {
              onSubmit();
            } else {
              teamBloc.add(
                TeamLeaveEvent(
                  teamId: widget.team.id,
                  userId: widget.user.id,
                ),
              );
              teamBloc.stream.listen((event) {
                if (event.statusTeam == TeamStatus.success) {
                  Navigator.of(context).pop();
                }
              });
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff22c55e),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
              vertical: 10,
            ),
          ),
          child: Text(
            widget.team.creatorId == widget.user.id ? "Update" : "Leave",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
