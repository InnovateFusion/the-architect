import '../bloc/post/post_bloc.dart';
import '../widget/custom_bottom_navigation.dart';
import '../widget/post/post.dart';
import '../widget/profile_image.dart';
import '../widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widget/tag.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var search = '';
  final List<String> selectedTags = [];

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

  void searchPosts(String search) {
    print('search: $search');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            height: double.infinity,
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Search(onPressed: searchPosts),
                    const SizedBox(width: 10),
                    const ProfileImage(
                        imageUrl: 'assets/images/me.jpg', size: 50.0),
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
                BlocBuilder<PostBloc, PostState>(
                  builder: (context, state) {
                    if (state is PostInitial || state is PostLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is PostsViewsLoaded) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            return Post(post: state.posts[index]);
                          },
                        ),
                      );
                    } else if (state is PostError) {
                      return const Center(child: Text('Error loading posts'));
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
          const Positioned(
              bottom: 10,
              left: 40,
              right: 40,
              child: CustomBottomNavigation(
                  currentNav: 0) // Add custom bottom navigation
              ),
        ]),
      ),
    );
  }
}
