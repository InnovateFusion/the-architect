import 'package:architect/features/architect/domains/entities/post.dart'
    as post_entity;
import 'package:architect/features/architect/presentations/widget/post/clone.dart';
import 'package:architect/features/architect/presentations/widget/post/react.dart';
import 'package:architect/features/architect/presentations/widget/post/user_info.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../page/detail.dart';

class Post extends StatefulWidget {
  final post_entity.Post post;

  const Post({Key? key, required this.post}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

String capitalize(String input) {
  if (input.isEmpty) {
    return input;
  }
  return input[0].toUpperCase() + input.substring(1);
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
<<<<<<< HEAD
              GestureDetector(
                onDoubleTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailPage(
                                post: widget.post,
                              )));
                },
                child: Image.network(
                  widget.post.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
=======
              Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
>>>>>>> ccf8b2c (:boom: add new feature)
              ),
              Positioned(
                top: 10,
                left: 10,
                child: UserInfo(
                  name:
                      '${capitalize(widget.post.firstName)} ${capitalize(widget.post.lastName)}',
                  date: DateFormat('MMM d y').format(widget.post.date),
                  imageUrl: 'assets/images/me.jpg',
                  id: widget.post.userId,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Clone(
<<<<<<< HEAD
                  color: widget.post.isCloned
                      ? Colors.black
                      : const Color.fromARGB(255, 141, 133, 137)
                          .withOpacity(0.7),
                  onPressed: () {},
=======
                  color: widget.isCloned
                      ? Colors.black
                      : const Color.fromARGB(255, 141, 133, 137)
                          .withOpacity(0.7),
                  onPressed: widget.onCloned,
>>>>>>> ccf8b2c (:boom: add new feature)
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: Row(
                  children: [
                    React(
<<<<<<< HEAD
                      text: widget.post.like.toString(),
                      isColor: widget.post.isLiked,
                      icon: Icon(Icons.favorite,
                          size: 35,
                          color: widget.post.isLiked
                              ? const Color.fromARGB(255, 230, 57, 57)
                              : const Color.fromARGB(255, 255, 255, 255)),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 20),
                    React(
                        text: widget.post.clone.toString(),
                        isColor: widget.post.isCloned,
                        icon: Icon(Icons.cyclone,
                            size: 35,
                            color: widget.post.isCloned
                                ? const Color.fromARGB(255, 230, 57, 57)
                                : const Color.fromARGB(255, 255, 255, 255)),
                        onPressed: () {}),
=======
                      text: widget.likes.toString(),
                      isColor: widget.isLiked,
                      icon: Icon(Icons.favorite,
                          size: 40,
                          color: widget.isLiked
                              ? const Color(0xFFE1DBDB)
                              : Colors.black),
                      onPressed: widget.onLiked,
                    ),
                    const SizedBox(width: 20),
                    React(
                      text: widget.clones.toString(),
                      isColor: widget.isCloned,
                      icon: Icon(Icons.cyclone,
                          size: 40,
                          color: widget.isLiked
                              ? const Color(0xFFE1DBDB)
                              : Colors.black),
                      onPressed: widget.onCloned,
                    ),
>>>>>>> ccf8b2c (:boom: add new feature)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
