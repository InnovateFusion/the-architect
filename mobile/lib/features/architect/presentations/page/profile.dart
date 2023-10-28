import 'dart:math';

import 'package:architect/features/architect/presentations/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domains/entities/user.dart';
import '../bloc/post/post_bloc.dart';
import '../bloc/user/user_bloc.dart';
import '../widget/gallery_item.dart';

final random = Random();

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
  static const String name = '/profile';
}

class _ProfilePageState extends State<ProfilePage> {
  late User fetchedUser = const User(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      image: '',
      followers: 0,
      following: 0,
      bio: '',
      country: '');
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    userBloc = sl<UserBloc>();
    userBloc.add(ViewUserEvent(id: widget.userId));

    userBloc.stream.listen((event) {
      if (event is UserLoaded) {
        fetchedUser = event.user;
      }
    });
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
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<PostBloc>()
          ..add(
            ViewsPosts(userId: widget.userId),
          ),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child:
                  BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                if (state is PostInitial || state is PostLoading) {
                  return const SizedBox(
                    height: 700,
                    child: LoadingIndicator(),
                  );
                } else if (state is PostsViewsLoaded) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 170,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/cover/${random.nextInt(8) + 1}.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              )
                            ],
                          ),
                          Positioned(
                            top: 120,
                            right: deviceWidth / 2 - 50 - 10,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 7,
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 100,
                              width: 100,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                child: fetchedUser.image.isNotEmpty
                                    ? Image(
                                        image: NetworkImage(fetchedUser.image),
                                        fit: BoxFit.fill,
                                      )
                                    : const Image(
                                        image: AssetImage(
                                            "assets/images/user.png"),
                                        fit: BoxFit.fill,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        capitalizeAll(
                            "${fetchedUser.firstName} ${fetchedUser.lastName}"),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        capitalizeAll(fetchedUser.bio),
                        style: const TextStyle(
                          color: Color(0xFF9F9C9E),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        softWrap: true,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                fetchedUser.followers.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                "Followers",
                                style: TextStyle(
                                  color: Color(0xFF9F9C9E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            children: [
                              Text(
                                fetchedUser.following.toString(),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                "Following",
                                style: TextStyle(
                                  color: Color(0xFF9F9C9E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(width: 40),
                          Column(
                            children: [
                              Text(
                                state.posts.length.toString(),
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Text(
                                "Posts",
                                style: TextStyle(
                                  color: Color(0xFF9F9C9E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                for (int i = 0;
                                    i < (state.posts.length / 2).ceil();
                                    i++)
                                  if (i % 2 == 0)
                                    GalleryItem(
                                      user: fetchedUser,
                                      half: false,
                                      post: state.posts[i],
                                    )
                                  else
                                    GalleryItem(
                                      user: fetchedUser,
                                      half: true,
                                      post: state.posts[i],
                                    ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                for (int i = (state.posts.length / 2).ceil();
                                    i < state.posts.length;
                                    i++)
                                  if (i % 2 == 0)
                                    GalleryItem(
                                      user: fetchedUser,
                                      half: false,
                                      post: state.posts[i],
                                    )
                                  else
                                    GalleryItem(
                                      user: fetchedUser,
                                      half: true,
                                      post: state.posts[i],
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else if (state is PostError) {
                  return const Center(child: Text('Error loading posts'));
                } else {
                  return Container();
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
