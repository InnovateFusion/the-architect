import 'package:architect/features/architect/presentations/page/home.dart';
import 'package:architect/features/architect/presentations/widget/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domains/entities/post.dart';
import '../../domains/entities/user.dart';
import '../bloc/post/post_bloc.dart';
import 'post_create.dart';

class DetailPage extends StatelessWidget {
  final User user;
  const DetailPage({
    required this.user,
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;
  static const String name = '/detail';
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

  void navigate(BuildContext context) {
    BlocProvider.of<PostBloc>(context).add(
      DeletePostEvent(postId: post.id),
    );
    Navigator.popUntil(context, (route) {
      return route.runtimeType == HomePage;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          user: user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 238, 244),
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ClipRRect(
                      child: Image.network(
                        post.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
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
                  if (post.userId == user.id)
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.385,
                      right: 10,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreatePostPage(
                                          user: user,
                                          imageUrl: post.image,
                                          post: post,
                                        )),
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 215, 219, 228),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (cntx) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Are you sure?",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: const Text(
                                      "Do you want to delete this post?",
                                      textAlign: TextAlign.center,
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(cntx).pop();
                                        },
                                        child: const Text("Cancel",
                                            style:
                                                TextStyle(color: Colors.black)),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(cntx).pop();
                                          navigate(context);
                                        },
                                        child: const Text("Delete",
                                            style:
                                                TextStyle(color: Colors.red)),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 215, 219, 228),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.delete,
                                  size: 20,
                                  color: Color.fromARGB(255, 252, 4, 4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.5 - 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 236, 238, 244),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ProfileImage(imageUrl: post.userImage, size: 45),
                          const SizedBox(width: 10),
                          Flexible(
                            child: Text(
                              capitalizeAll(post.title),
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...post.tags.map((e) => Container(
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 7,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 215, 219, 228),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                        child: Text(
                                      capitalizeAll(e),
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                      ),
                                    )),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        capitalize(
                          post.content,
                        ),
                        style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 14,
                          height: 1.25,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
