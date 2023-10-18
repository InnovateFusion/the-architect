import 'package:architect/features/architect/presentations/bloc/post/post_bloc.dart';
import 'package:architect/features/architect/presentations/widget/custom_bottom_navigation.dart';
import 'package:architect/features/architect/presentations/widget/post/post.dart';
import 'package:architect/features/architect/presentations/widget/profile_image.dart';
import 'package:architect/features/architect/presentations/widget/search.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widget/tag.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onSearchPressed() {
    print('Search');
  }

  late PostBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _postBloc = sl<PostBloc>();
    _postBloc.add(const AllPosts(tags: [], search: ''));
  }

  final List<Post> posts = [
    Post(
      name: 'John Doe',
      date: '2 hours ago',
      isLiked: true,
      isCloned: false,
      userImageUrl: 'assets/images/me.jpg',
      imageUrl: 'assets/images/me.jpg',
      likes: 10,
      clones: 5,
      onLiked: () {},
      onCloned: () {},
    ),
    Post(
      name: 'Alice Smith',
      date: '3 hours ago',
      isLiked: true,
      isCloned: false,
      userImageUrl: 'assets/images/me.jpg',
      imageUrl: 'assets/images/me.jpg',
      likes: 20,
      clones: 8,
      onLiked: () {},
      onCloned: () {},
    ),
  ];

  final List<Tag> tags = [
    Tag(
        text: 'Explore',
        color: Colors.black,
        textColor: const Color(0xFFE1DBDB),
        textSize: 13,
        onPressed: () {}),
    Tag(
        text: 'Interior',
        color: const Color.fromARGB(255, 255, 255, 255),
        textColor: Colors.black,
        textSize: 13,
        onPressed: () {}),
    Tag(
        text: 'Exterior',
        color: const Color.fromARGB(255, 255, 255, 255),
        textColor: Colors.black,
        textSize: 13,
        onPressed: () {}),
    Tag(
        text: 'Floor',
        color: const Color.fromARGB(255, 255, 255, 255),
        textColor: Colors.black,
        textSize: 13,
        onPressed: () {}),
    // Add more tags as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            sl<PostBloc>()..add(const AllPosts(tags: [], search: '')),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(children: [
            Container(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                width: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Search(onPressed: onSearchPressed),
                          const SizedBox(width: 10),
                          const ProfileImage(
                              imageUrl: 'assets/images/me.jpg', size: 50.0)
                        ],
                      ),
                      const SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: tags
                              .map((tag) => Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: tag,
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Expanded(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(children: [
                              BlocBuilder<PostBloc, PostState>(
                                  builder: (context, state) {
                                if (state is PostInitial) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is PostsViewsLoaded) {
                                  return BlocBuilder<PostBloc, PostState>(
                                    builder: (contxt, state) {
                                      return Text(state.toString());
                                    },
                                  );
                                } else if (state is PostLoading) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (state is PostError) {
                                  return const Center(
                                      child: Text('Error loading posts'));
                                } else {
                                  return Container();
                                }
                              })
                            ])),
                      ),
                    ])),
            const Positioned(
                bottom: 10,
                left: 40,
                right: 40,
                child: CustomBottomNavigation(
                    currentNav: 0) // Add custom bottom navigation
                ),
          ]),
        ),
      ),
    );
  }
}
