import 'dart:io';

import 'package:architect/features/architect/domains/entities/post.dart';
import 'package:architect/features/architect/presentations/bloc/post/post_bloc.dart';
import 'package:architect/features/architect/presentations/page/detail.dart';
import 'package:architect/features/architect/presentations/page/setting.dart';
import 'package:architect/features/architect/presentations/widget/tag.dart';
import 'package:architect/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domains/entities/user.dart';

class CreatePostPage extends StatefulWidget {
  final User user;
  final String imageUrl;
  final Post? post;

  const CreatePostPage({
    required this.user,
    required this.imageUrl,
    this.post,
    Key? key,
  }) : super(key: key);

  static const String name = '/post/create';

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final List<String> tags = [
    "exterior",
    "facade",
    "outdoor",
    "landscape",
    "architectural facade",
    "outdoor design",
    "interior",
    "indoor",
    "interior design",
    "space planning",
    "furniture design",
    "decor",
    "lighting"
  ];

  late Post post;
  final Set<String> selectedTags = {};

  bool isSelected(String tag) => selectedTags.contains(tag);

  void onPressedTag(String tag) {
    if (isSelected(tag)) {
      setState(() {
        selectedTags.remove(tag);
      });
    } else {
      setState(() {
        selectedTags.add(tag);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _titleController.text = widget.post!.title;
      _descriptionController.text = widget.post!.content;
      selectedTags.addAll(widget.post!.tags);
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => sl<PostBloc>(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: BlocListener<PostBloc, PostState>(
              listener: (context, state) {
                if (state is PostLoaded) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(user: widget.user, post: state.post),
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 435,
                            child: Image.network(widget.imageUrl,
                                fit: BoxFit.cover),
                          ),
                          Positioned(
                            top: 15,
                            left: 15,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 0, 0, 0),
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
                          Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Setting(
                                    user: widget.user,
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: FileImage(File(widget.user.image)),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: tags.map((e) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Tag(
                                isSelected: isSelected(e),
                                text: e,
                                onPressed: onPressedTag,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextField(
                              controller: _titleController,
                              decoration: const InputDecoration(
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                                hintText: 'Title',
                              ),
                              onChanged: (value) => setState(
                                    () {
                                      _titleController.text = value;
                                    },
                                  )),
                          const SizedBox(height: 20),
                          TextField(
                            controller: _descriptionController,
                            maxLines: 3,
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                              hintText: 'Description',
                            ),
                            onChanged: (value) => setState(
                              () {
                                _descriptionController.text = value;
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (widget.post != null) {
                                    Post xxx = widget.post!;
                                    BlocProvider.of<PostBloc>(context).add(
                                      EditPostEvent(
                                        userId: widget.user.id,
                                        image: widget.imageUrl,
                                        postId: xxx.id,
                                        title: _titleController.text,
                                        content: _descriptionController.text,
                                        tags: selectedTags.toList(),
                                      ),
                                    );
                                  } else {
                                    BlocProvider.of<PostBloc>(context).add(
                                      CreatePostEvent(
                                        image: widget.imageUrl,
                                        title: _titleController.text,
                                        content: _descriptionController.text,
                                        tags: selectedTags.toList(),
                                        userId: widget.user.id,
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.send_outlined,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 15),
                                      Text(
                                        widget.post != null ? 'Update' : 'Post',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
