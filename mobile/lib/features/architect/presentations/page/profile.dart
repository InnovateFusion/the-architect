import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/post/post_bloc.dart';
import '../widget/gallery_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
    required this.userId,
  }) : super(key: key);

  final String userId;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<PostBloc>()
          ..add(
            ViewsPosts(userId: userId),
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
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostsViewsLoaded) {
                  return Column(
                    children: [
                      Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 170,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage("assets/images/me.jpg"),
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
                              child: const ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(50),
                                ),
                                child: Image(
                                  image: AssetImage("assets/images/me.jpg"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        "Sara William",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        "Embrace the glorious mess that you are",
                        style: TextStyle(
                          color: Color(0xFF9F9C9E),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                        softWrap: true,
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                "144 K",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                  color: Color(0xFF9F9C9E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 40),
                          Column(
                            children: [
                              Text(
                                "574",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                "Following",
                                style: TextStyle(
                                  color: Color(0xFF9F9C9E),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 40),
                          Column(
                            children: [
                              Text(
                                "139",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
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
                                      half: false,
                                      post: state.posts[i],
                                    )
                                  else
                                    GalleryItem(
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
                                      half: true,
                                      post: state.posts[i],
                                    )
                                  else
                                    GalleryItem(
                                      half: false,
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
