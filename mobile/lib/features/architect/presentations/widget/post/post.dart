import 'package:architect/features/architect/domains/entities/post.dart'
    as post_entity;
import 'package:architect/features/architect/presentations/bloc/post/post_bloc.dart';
import 'package:architect/features/architect/presentations/page/profile.dart';
import 'package:architect/features/architect/presentations/widget/post/react.dart';
import 'package:architect/features/architect/presentations/widget/post/user_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../domains/entities/user.dart';
import '../../page/chat.dart';
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
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.27,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPage(user: widget.user, post: post),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      widget.post.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfilePage(
                            user: widget.user, userId: post.userId)),
                  ),
                  child: UserInfo(
                    user: widget.user,
                    name:
                        '${capitalize(widget.post.firstName)} ${capitalize(widget.post.lastName)}',
                    date: DateFormat('MMM d y').format(widget.post.date),
                    imageUrl: widget.post.userImage,
                    id: widget.post.userId,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              post.title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                React(
                  text: post.like.toString(),
                  isColor: post.isLiked,
                  icon: Icon(Icons.favorite,
                      size: 32,
                      color: post.isLiked
                          ? const Color.fromARGB(255, 230, 57, 57)
                          : Colors.black),
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
                  icon: Icon(Icons.graphic_eq,
                      size: 32,
                      color: post.isCloned
                          ? const Color.fromARGB(255, 57, 218, 230)
                          : Colors.black),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
