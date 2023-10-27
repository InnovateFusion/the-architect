import 'dart:io';

import 'package:flutter/material.dart';
import 'package:architect/features/architect/domains/entities/post.dart'
    as post;
import 'package:architect/features/architect/presentations/bloc/user/user_bloc.dart';
import 'package:architect/features/architect/presentations/page/setting.dart';
import 'package:architect/features/architect/presentations/widget/loading_indicator.dart';
import 'package:architect/features/architect/presentations/widget/post/post.dart';
import 'package:architect/injection_container.dart';

import '../../domains/entities/user.dart';
import '../bloc/post/post_bloc.dart';
import '../widget/custom_bottom_navigation.dart';
import '../widget/search.dart';
import '../widget/tag.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PostBloc postBloc;
  late UserBloc userBloc;
  late User user = const User(
    id: '',
    firstName: '',
    lastName: '',
    email: '',
    image: '',
    followers: 0,
    following: 0,
    bio: '',
    country: '',
  );

  final List<post.Post> posts = [];
  final List<post.Post> filteredPosts = [];
  final TextEditingController searchController = TextEditingController();

  final List<String> xTags = [
    'Explore',
    'Interior',
    'Exterior',
    'Architecture',
    'Design',
  ];

  final List<String> selectedTags = [
    'Explore',
  ];

  List<Tag> tags = [];

  @override
  void initState() {
    super.initState();

    userBloc = sl<UserBloc>();
    userBloc.add(ViewUsersEvent());
    userBloc.stream.listen((event) {
      if (event is UserLoaded) {
        setState(() {
          user = event.user;
        });
      }
    });

    postBloc = sl<PostBloc>();
    postBloc.add(const AllPosts());
    postBloc.stream.listen((event) {
      if (event is PostsViewsLoaded) {
        setState(() {
          posts.addAll(event.posts);
        });
      }
    });
  }

  void searchPosts(String search) {
    setState(() {
      filteredPosts.clear();
      filteredPosts.addAll(posts
          .where(
              (post) => post.title.toLowerCase().contains(search.toLowerCase()))
          .toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Search(
                        searchController: searchController,
                        onChanged: searchPosts,
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Setting(
                              user: user,
                            ),
                          ),
                        ),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(File(user.image)),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: tags
                          .map((tag) => GestureDetector(
                                onTap: () => tag.onPressed(tag.text),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: tag,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  StreamBuilder(
                    stream: postBloc.stream,
                    builder:
                        (BuildContext context, AsyncSnapshot<Object> snapshot) {
                      if (snapshot.hasData) {
                        final event = snapshot.data;
                        if (posts.isNotEmpty &&
                            (event is PostLoading || event is PostInitial)) {
                          return listPosts();
                        } else if (event is PostsViewsLoaded) {
                          posts.addAll(event.posts);
                          return listPosts();
                        } else if (event is PostError) {
                          return Expanded(
                            child: Center(
                              child: Text(event.message),
                            ),
                          );
                        }
                      }
                      return const LoadingIndicator();
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              left: 40,
              right: 40,
              child: CustomBottomNavigation(user: user, currentNav: 0),
            ),
          ],
        ),
      ),
    );
  }

  Expanded listPosts() {
    return Expanded(
        child: ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return Post(user: user, post: posts[index]);
      },
    ));
  }
}
