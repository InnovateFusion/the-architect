import 'package:architect/widget/custom_bottom_navigation.dart';
import 'package:architect/widget/post/post.dart';
import 'package:architect/widget/profile_image.dart';
import 'package:architect/widget/search.dart';
import 'package:flutter/material.dart';

import '../widget/tag.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  void onSearchPressed() {
    print('Search');
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
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              width: double.infinity,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                    child: Column(
                      children: posts.map((post) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Post(
                            name: post.name,
                            date: post.date,
                            isLiked: post.isLiked,
                            isCloned: post.isCloned,
                            userImageUrl: post.userImageUrl,
                            imageUrl: post.imageUrl,
                            likes: post.likes,
                            clones: post.clones,
                            onLiked: post.onLiked,
                            onCloned: post.onCloned,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
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
    );
  }
}
