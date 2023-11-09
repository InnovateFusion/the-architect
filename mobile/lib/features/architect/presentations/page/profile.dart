import 'dart:async';
import 'dart:math';

import 'package:architect/features/architect/domains/entities/post.dart';
import 'package:architect/features/architect/presentations/widget/error.dart';
import 'package:architect/features/architect/presentations/widget/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../../domains/entities/user.dart';
import '../bloc/post/post_bloc.dart';
import '../bloc/user/user_bloc.dart';
import '../widget/gallery_item.dart';

final random = Random();
int rand = random.nextInt(8) + 1;

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    required this.user,
    required this.userId,
  }) : super(key: key);

  final String userId;
  final User user;

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
  late PostBloc postBloc;
  late List<User> followingUsers = [];

  late bool isFollowing = false;

  int followers = 0;
  int following = 0;

  @override
  void initState() {
    super.initState();

    userBloc = sl<UserBloc>();
    userBloc.add(ViewUserEvent(id: widget.userId));
    userBloc.add(FollowersUserEvent(id: widget.userId));
    postBloc = sl<PostBloc>();
    postBloc.add(ViewsPosts(userId: widget.userId));

    userBloc.stream.listen((event) {
      if (event is UserLoaded) {
        fetchedUser = event.user;
      }

      if (event is UserFollowingsLoaded) {
        followingUsers = event.user;
      }

      for (final user in followingUsers) {
        if (user.id == widget.user.id) {
          isFollowing = true;
        }
      }
      followers = fetchedUser.followers;
      following = fetchedUser.following;
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

  void followAndUnFollow(BuildContext context) {
    if (isFollowing) {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        context.read<UserBloc>().add(UnFollowUserEvent(id: widget.userId));
        setState(() {
          isFollowing = !isFollowing;
          followers--;
        });
      });
    } else {
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce = Timer(const Duration(milliseconds: 2000), () {
        context.read<UserBloc>().add(FollowUserEvent(id: widget.userId));
        setState(() {
          isFollowing = !isFollowing;
          followers++;
        });
      });
    }
  }

  Timer? _debounce;

  @override
  void dispose() {
    userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 238, 244),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocProvider(
            create: (context) =>
                sl<PostBloc>()..add(ViewsPosts(userId: widget.userId)),
            child: Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child:
                  BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                if (state.otherPostStatus == PostStatus.loading ||
                    state.otherPostStatus == PostStatus.initial) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 350),
                    child: LoadingIndicator(),
                  );
                } else if (state.otherPostStatus == PostStatus.success) {
                  return displayPost(context, deviceWidth, state.userPosts);
                } else if (state.otherPostStatus == PostStatus.failure) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 350),
                    child: ErrorDisplay(message: 'Unable to load posts'),
                  );
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

  Widget displayPost(
      BuildContext context, double deviceWidth, List<Post> posts) {
    return Column(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/cover/$rand.jpg"),
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
              top: 10,
              left: 10,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff22c55e),
                    borderRadius: BorderRadius.circular(5)),
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
            ),
            Positioned(
              top: 150,
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
                          image: AssetImage("assets/images/user.png"),
                          fit: BoxFit.fill,
                        ),
                ),
              ),
            ),
          ],
        ),
        Text(
          capitalizeAll("${fetchedUser.firstName} ${fetchedUser.lastName}"),
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          capitalizeAll(fetchedUser.bio),
          style: const TextStyle(
            color: Color.fromARGB(255, 121, 119, 121),
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
          softWrap: true,
        ),
        if (widget.user.id != fetchedUser.id) const SizedBox(height: 20),
        if (widget.user.id != fetchedUser.id)
          GestureDetector(
            onTap: () => followAndUnFollow(context),
            child: Container(
              height: 45,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: isFollowing ? Colors.black : Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    spreadRadius: 0.4,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  isFollowing ? 'Unfollow' : 'Follow',
                  style: TextStyle(
                    color: isFollowing ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: isFollowing ? FontWeight.w400 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text(
                  followers.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "Followers",
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 119, 121),
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
                  following.toString(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "Following",
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 119, 121),
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
                  posts.length.toString(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "Posts",
                  style: TextStyle(
                    color: Color.fromARGB(255, 121, 119, 121),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  for (int i = 0; i < (posts.length / 2).ceil(); i++)
                    if (i % 2 == 0)
                      GalleryItem(
                        user: fetchedUser,
                        half: false,
                        post: posts[i],
                      )
                    else
                      GalleryItem(
                        user: fetchedUser,
                        half: true,
                        post: posts[i],
                      ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  for (int i = (posts.length / 2).ceil(); i < posts.length; i++)
                    if (i % 2 == 0)
                      GalleryItem(
                        user: fetchedUser,
                        half: false,
                        post: posts[i],
                      )
                    else
                      GalleryItem(
                        user: fetchedUser,
                        half: true,
                        post: posts[i],
                      ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
