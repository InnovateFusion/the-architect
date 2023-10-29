import 'package:architect/features/architect/domains/entities/post.dart'
    as post_entity;
import 'package:architect/features/architect/presentations/bloc/post/post_bloc.dart';
import 'package:architect/features/architect/presentations/page/chat.dart';
import 'package:architect/features/architect/presentations/widget/post/clone.dart';
import 'package:architect/features/architect/presentations/widget/post/react.dart';
import 'package:architect/features/architect/presentations/widget/post/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domains/entities/user.dart';
import '../../page/detail.dart';

class Post extends StatefulWidget {
  final post_entity.Post post;
  final User user;
  final List<post_entity.Post> posts;
  final int index;

  const Post({
    Key? key,
    required this.post,
    required this.user,
    required this.posts,
    required this.index,
  }) : super(key: key);

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
  late post_entity.Post post;

  @override
  void initState() {
    super.initState();
    post = widget.post;
  }

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
              GestureDetector(
                onDoubleTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailPage(user: widget.user, post: post)));
                },
                child: Image.network(
                  widget.post.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: UserInfo(
                  user: widget.user,
                  name:
                      '${capitalize(widget.post.firstName)} ${capitalize(widget.post.lastName)}',
                  date: DateFormat('MMM d y').format(widget.post.date),
                  imageUrl: widget.post.userImage,
                  id: widget.post.userId,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Clone(
                  color: widget.post.isCloned
                      ? Colors.black
                      : const Color.fromARGB(255, 141, 133, 137)
                          .withOpacity(0.7),
                  onPressed: () {
                    BlocProvider.of<PostBloc>(context)
                        .add(ClonePostEvent(postId: widget.post.id));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chat(
                          user: widget.user,
                          post: widget.post,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: Row(
                  children: [
                    React(
                      text: post.like.toString(),
                      isColor: post.isLiked,
                      icon: Icon(Icons.favorite,
                          size: 35,
                          color: post.isLiked
                              ? const Color.fromARGB(255, 230, 57, 57)
                              : const Color.fromARGB(255, 255, 255, 255)),
                      onPressed: () {
                        if (post.isLiked) {
                          BlocProvider.of<PostBloc>(context)
                              .add(UnLikePostEvent(postId: post.id));
                          setState(() {
                            widget.posts[widget.index] = post.copyWith(
                                like: post.like - 1, isLiked: !post.isLiked);
                            post = widget.posts[widget.index];
                          });
                        } else {
                          BlocProvider.of<PostBloc>(context)
                              .add(LikePostEvent(postId: post.id));
                          setState(() {
                            widget.posts[widget.index] = post.copyWith(
                                like: post.like + 1, isLiked: !post.isLiked);
                            post = widget.posts[widget.index];
                          });
                        }
                      },
                    ),
                    const SizedBox(width: 20),
                    React(
                        text: post.clone.toString(),
                        isColor: post.isCloned,
                        icon: Icon(Icons.cyclone,
                            size: 35,
                            color: post.isCloned
                                ? const Color.fromARGB(255, 57, 218, 230)
                                : const Color.fromARGB(255, 255, 255, 255)),
                        onPressed: () {}),
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
