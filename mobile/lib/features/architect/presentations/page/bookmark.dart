import 'dart:io';

import 'package:architect/features/architect/presentations/bloc/post/post_bloc.dart';
import 'package:architect/features/architect/presentations/page/setting.dart';
import 'package:architect/features/architect/presentations/page/skeleton/bookmark.dart';
import 'package:architect/features/architect/presentations/widget/error.dart';
import 'package:architect/features/architect/presentations/widget/gallery_item.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domains/entities/user.dart';

class BookMark extends StatelessWidget {
  final User user;
  static const String name = '/bookmark';
  const BookMark({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<PostBloc>()
          ..add(
            ViewsPosts(userId: user.id),
          ),
        child: Scaffold(
          backgroundColor: const Color.fromARGB(255, 236, 238, 244),
          body: BlocBuilder<PostBloc, PostState>(
            builder: (context, state) {
              if (state.otherPostStatus == PostStatus.loading) {
                return const BooKMarkShimmer();
              } else if (state.otherPostStatus == PostStatus.success) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "My",
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "Gallery",
                                        style: TextStyle(
                                          fontSize: 30,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Capturing moment of Ai",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
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
                                        image: FileImage(File(user.image)),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 20),
                              child: displaysBookMark(state),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (state.otherPostStatus == PostStatus.failure) {
                return const SizedBox(
                    height: 550,
                    child: ErrorDisplay(
                      message: "Unable to load posts",
                    ));
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Column displaysBookMark(PostState state) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  for (int i = 0; i < (state.userPosts.length / 2).ceil(); i++)
                    if (i % 2 == 0)
                      GalleryItem(
                        user: user,
                        half: false,
                        post: state.userPosts[i],
                      )
                    else
                      GalleryItem(
                        user: user,
                        half: true,
                        post: state.userPosts[i],
                      ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  for (int i = (state.userPosts.length / 2).ceil();
                      i < state.userPosts.length;
                      i++)
                    if (i % 2 == 0)
                      GalleryItem(
                        user: user,
                        half: false,
                        post: state.userPosts[i],
                      )
                    else
                      GalleryItem(
                        user: user,
                        half: true,
                        post: state.userPosts[i],
                      ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
