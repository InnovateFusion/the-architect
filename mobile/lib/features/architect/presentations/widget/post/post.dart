import 'package:architect/features/architect/presentations/widget/post/clone.dart';
import 'package:architect/features/architect/presentations/widget/post/react.dart';
import 'package:architect/features/architect/presentations/widget/post/user_info.dart';
import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  final String name;
  final String date;
  final String imageUrl;
  final int likes;
  final int clones;
  final bool isLiked;
  final bool isCloned;
  final String userImageUrl;
  final VoidCallback onLiked;
  final VoidCallback onCloned;

  const Post({
    Key? key,
    required this.name,
    required this.date,
    required this.isLiked,
    required this.isCloned,
    required this.userImageUrl,
    required this.imageUrl,
    required this.likes,
    required this.clones,
    required this.onLiked,
    required this.onCloned,
  }) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.0),
        child: SizedBox(
          height: 400,
          child: Stack(
            children: [
              Image.asset(
                widget.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                top: 10,
                left: 10,
                child: UserInfo(
                  name: widget.name,
                  date: widget.date,
                  imageUrl: widget.userImageUrl,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Clone(
                  color: widget.isCloned ? Colors.black : Colors.white,
                  onPressed: widget.onCloned,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 20,
                child: Row(
                  children: [
                    React(
                      text: "100",
                      isColor: widget.isLiked,
                      icon: Icon(Icons.favorite,
                          size: 25,
                          color: widget.isLiked
                              ? const Color(0xFFE1DBDB)
                              : Colors.black),
                      onPressed: widget.onLiked,
                    ),
                    const SizedBox(width: 20),
                    React(
                      text: "100",
                      isColor: widget.isCloned,
                      icon: Icon(Icons.cyclone,
                          size: 25,
                          color: widget.isLiked
                              ? const Color(0xFFE1DBDB)
                              : Colors.black),
                      onPressed: widget.onCloned,
                    ),
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
